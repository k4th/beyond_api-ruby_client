# frozen_string_literal: true

RSpec.describe BeyondApi::ProductManagement::Variation, vcr: { match_requests_on: [:method, :uri] } do
  let(:client) { described_class.new(api_url: ENV.fetch('API_URL', nil), access_token: beyond_access_token) }

  describe '.all' do
    it 'returns all variations of a product' do
      response = client.all('99d80d40-3751-4e47-ba15-36ede0269ed7', size: 100, page: 0)

      expect(response).not_to be nil
      expect(response.dig(:embedded, :variations)).to be_kind_of(Array)
      expect(response[:page]).to be_kind_of(Hash)
    end
  end

  describe '.update' do
    it 'updates a variation partially' do
      variation = {
        sales_price: {
          tax_model: 'GROSS',
          amount: 8.7,
          currency: 'GBP'
        },
        list_price: {
          tax_model: 'GROSS',
          amount: 10,
          currency: 'GBP'
        },
        manufacturer_price: {
          tax_model: 'GROSS',
          amount: 11,
          currency: 'GBP'
        },
        sku: '1010'
      }
      response = client.update('99d80d40-3751-4e47-ba15-36ede0269ed7',
                               '92b00af6-a273-4850-b8dd-f1ca7239f17a',
                               variation)

      expect(response).not_to be nil
      expect(response[:sku]).to eq('1010')
    end
  end
end
