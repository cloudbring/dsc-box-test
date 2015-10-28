# Dollar Shave Club Testing Challenge

# Author: Emmanuel Mwangi <emmanuelm@gmail.com>

# Starting on https://www.dollarshaveclub.com/our-products, write 2 test scripts
# using your preferred framework:
#   1. Verify that the guest can add two “Magnanimous Post Shave” moisturizers.
#   2. Verify that the guest can remove boogies “Dream Hair Cream” from their box

require "rubygems"
require "minitest/autorun"
require "watir-webdriver"
require "watir-scroll"

class DollarShaveClubCart < MiniTest::Test
  def site_url
    'https://www.dollarshaveclub.com/our-products'
  end

  def setup
    @b ||= Watir::Browser.new :firefox
  end

  def teardown
    @b.close
  end

  # Add a named item to the shopping Cart from a section products page
  #
  # ==== Options
  #
  # * +:item+     - Exact (XPATH) name of item to add to the cart
  # * +:qty+      - [optional] Quantity of item to add to the cart
  # * +:tag+      - [optional] Headline tag for item text
  # * +:btn_text+ - [optional] Text of the shopping cart CTA button ex. 'Add'
  # ==== Examples
  #
  # Be careful with the item text. It has to be exact. +<br>+ tags collapse
  # whitespace
  #
  #   add_to_cart(item: 'DreamHair Cream')
  #   add_to_cart(item: 'MagnanimousPost Shave')
  def add_to_box(options = {})
    options[:qty] ||= 2
    options[:tag] ||= 'h5'
    options[:btn_text] ||= 'add'

    product_header_xpath = "#{options[:tag]}[contains(., '#{options[:item]}')]"
    sibling_btn_xpath = "following-sibling::button[contains(., '#{options[:btn_text]}')]"
    add_btn_xpath = "//#{product_header_xpath}/#{sibling_btn_xpath}"

    # Adding / Subtracting Magic Strings
    @add_call = {data_icon: 'quantity-plus'}
    @subtract_call = {data_icon: 'quantity-minus'}

    @empty_box_msg_fragment = "Your box is empty"

    # Add To Cart
    @b.element(xpath: add_btn_xpath)
      .when_present
      .click

    # Select Quantity
    until @b.span(class: 'quantity').text.to_i == options[:qty]
      starting_quantity = @b.span(class: 'quantity').text.to_i

      # FIX: [@HTML] Use something other than the data-icon for denoting add action
      @b.element(data_icon: 'quantity-plus').when_present.click

      # FIX: Unchecked String to Int conversion
      Watir::Wait.until { @b.span(class: 'quantity').text.to_i == (starting_quantity + 1) }
    end

    @b.button(class: 'confirm').when_present.click

  end

  def checkout_qty(options = {})
    options[:tag] ||= 'h3'

    qty_btn_xpath = "//h3[contains(., '#{options[:item]}')]/following-sibling::button"
    qty_btn = @b.element(xpath: qty_btn_xpath)
    Watir::Wait.until { qty_btn.text =~ /^QTY/i }

    qty_btn
  end

  def test_add_box_items
    @b.goto site_url

    # Open Section - Shave
    @b.element(text: 'Shave').when_present.click

    # Note: Whitespace of 'MagnanimousPost' because there is a <br> tag inbetween
    add_to_box(item: 'MagnanimousPost Shave', qty: 2)

    # 1 Assert Per Test
    assert_equal 'QTY. 2', checkout_qty(item:'Magnanimous Post Shave').text
  end

  def remove_item(options={})
    # Click on the QTY button
    checkout_qty(item: 'Dream Hair Cream').click

    until @b.span(class: 'quantity').text.to_i == 0
      starting_quantity = @b.span(class: 'quantity').text.to_i
      @b.element(@subtract_call).when_present.click
      Watir::Wait.until { @b.span(class: 'quantity').text.to_i == (starting_quantity - 1) }
    end
  end

  def test_remove_box_item
    @b.goto site_url

    # Open Section - Style
    @b.h1(text: 'Style').when_present.click

    add_to_box(item: 'DreamHair Cream', qty: 1)

    # DEBUG: Making sure I'm on the right track
    assert_equal 'QTY. 1', checkout_qty(item: 'Dream Hair Cream').text

    # Click on the QTY button
    checkout_qty(item: 'Dream Hair Cream').click

    Watir::Wait.until { @b.window.url.include? 'change-quantity' }

    until @b.span(class: 'quantity').text.to_i == 0
      starting_quantity = @b.span(class: 'quantity').text.to_i
      @b.element(@subtract_call).when_present.click
      Watir::Wait.until { @b.span(class: 'quantity').text.to_i == (starting_quantity - 1) }
    end

    # Wait for confirm button to read 'remove'
    Watir::Wait.until { @b.button(class: 'confirm').text =~ /^remove/i }

    # Click and close QTY dialog
    @b.button(class: 'confirm').when_present.click

    # At the Products page bring up box / shopping cart
    @b.element(class: 'show-box-manager').when_present.click

    @b.element(xpath: '//section[@class="caption"]/h2').wait_until_present

    caption = @b.element(xpath: '//section[contains(@class, "caption")]/h2')

    assert caption.text.include? @empty_box_msg_fragment
  end
end
