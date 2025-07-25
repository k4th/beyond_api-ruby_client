# frozen_string_literal: true

RSpec.describe BeyondApi::ProductManagement::VariationImage, vcr: { match_requests_on: [:method, :uri] } do
  let(:client) { described_class.new(api_url: ENV.fetch('API_URL', nil), access_token: beyond_access_token) }

  describe '.all' do
    it 'returns all images of a variation' do
      response = client.all('99d80d40-3751-4e47-ba15-36ede0269ed7',
                            '92b00af6-a273-4850-b8dd-f1ca7239f17a')

      expect(response).not_to be nil
      expect(response.dig(:embedded, :images)).to be_kind_of(Array)
    end
  end

  describe '.upload_multiple' do
    it 'uploads multiple images to a variation' do
      response = client.upload_multiple('99d80d40-3751-4e47-ba15-36ede0269ed7',
                                        '92b00af6-a273-4850-b8dd-f1ca7239f17a',
                                        ['spec/files/image2.png', 'spec/files/image3.png'],
                                        ['new-image2.png', 'new-image3.png'])

      expect(response).not_to be nil
      expect(response.dig(:embedded, :images)).to be_kind_of(Array)
    end
  end
end
