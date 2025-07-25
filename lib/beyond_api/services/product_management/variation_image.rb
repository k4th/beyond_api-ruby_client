# frozen_string_literal: true

module BeyondApi
  module ProductManagement
    # @example How to instantiate a client
    #   @client = BeyondApi::ProductManagement::VariationImage.new(api_url: 'https://example.com/api', access_token: 'your_token')
    class VariationImage < BaseService
      # Retrieve the images of a single variation of a variation product in a paged manner.
      #
      # @see https://developer.epages.com/beyond-docs/#list_variation_images
      #
      # @param product_id [String] the product UUID
      # @param variation_id [String] the variation UUID
      # @option params [Boolean] :paginated
      # @option params [Integer] :size the page size
      # @option params [Integer] :page the page number
      #
      # @return [Hash]
      #
      # @example
      #   @client.all(size: 100, page: 0)
      def all(product_id, variation_id, _params = {})
        get("products/#{product_id}/variations/#{variation_id}/images")
      end

      # Upload up to 10 images to the image storage and assign the URL of the images to the variation. The body of the request must contain the content of the images.
      #
      # @see https://developer.epages.com/beyond-docs/#upload_multiple_variation_images
      # @param product_id [String] the product UUID
      # @param variation_id [String] the variation UUID
      # @param image_paths [Array] an array of strings containing the path of each image
      # @param image_names [Array] an array of strings containing the file name of each image
      #
      # @return [Hash]
      #
      # @example
      #   image_paths = ['/home/epages/file1.png', '/home/epages/file2.png']
      #   image_names = ['file1.png', 'file2.png']
      #   @client.upload_multiple('4125b993-49fc-47c8-b9b3-76d8871e4e06',
      #                           'variation-uuid',
      #                           image_paths, image_names)
      def upload_multiple(product_id, variation_id, image_paths, image_names)
        upload_files("products/#{product_id}/variations/#{variation_id}/images",
                     { image: Utils.faraday_file_parts(image_paths) }, # body
                     { file_name: Utils.encode_filenames(image_names) }) # params
      end
    end
  end
end
