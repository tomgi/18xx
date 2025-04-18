# frozen_string_literal: true

module Engine
  module Game
    module G18NY
      module Entities
        COMPANIES = [
          {
            name: 'Albany Iron Works',
            sym: 'AIW',
            value: 20,
            revenue: 5,
            desc: 'Owning corporation may exchange this company for up to $80 off ' \
                  'a single bridge purchase or bridge tile upgrade.',
            color: nil,
            abilities: [
              {
                type: 'tile_discount',
                when: 'track',
                owner_type: 'corporation',
                terrain: 'water',
                discount: 80,
                count: 1,
              },
              {
                type: 'tile_lay',
                when: 'track',
                owner_type: 'corporation',
                tiles: [],
                hexes: [],
                reachable: true,
                special: false,
                consume_tile_lay: true,
                count: 1,
                closed_when_used_up: true,
              },
            ],
          },
          {
            name: 'Albany-Schenectady Stagecoach Line',
            sym: 'SC',
            value: 40,
            revenue: 10,
            desc: 'Owning corporation may exchange this company to place the stagecoach token in Albany. ' \
                  'The Stagecoach token is removed when the first 12H is purchased, ' \
                  "but may be replaced with one of the corporation's available tokens at that time.",
            color: nil,
            abilities: [
              {
                type: 'token',
                when: 'owning_corp_or_turn',
                owner_type: 'corporation',
                hexes: ['F20'],
                price: 0,
                teleport_price: 0,
                extra_action: true,
              },
              { type: 'reservation', remove: 'close', hex: 'F20', slot: 1 },
            ],
          },
          {
            name: 'West Point Foundry',
            sym: 'WPF',
            value: 60,
            revenue: 15,
            desc: 'Owning corporation may exchange this company for half off a train purchase ' \
                  '(up to a maximum of $200) from the bank or Bank Pool.',
            color: nil,
            abilities: [
              {
                type: 'train_discount',
                owner_type: 'corporation',
                discount: 0.5,
                trains: %w[2H 4H 6H],
                count: 1,
                closed_when_used_up: true,
              },
              {
                type: 'train_discount',
                owner_type: 'corporation',
                discount: 200,
                trains: %w[12H],
                count: 1,
                closed_when_used_up: true,
              },
            ],
          },
          {
            name: 'Pennsylvania Coal Fields',
            sym: 'PCF',
            value: 80,
            revenue: 20,
            desc: 'Owning corporation has exclusive rights to claim coal tokens.',
            color: nil,
          },
          {
            name: 'Erie Canal',
            sym: 'EC',
            value: 140,
            revenue: 100,
            desc: 'Pays $10 per operating round for every unimproved canal hex (marked on the map with an E). ' \
                  'May not be sold. Closes when the last canal hex is improved or with the purchase of the ' \
                  'first 12H train.',
            color: nil,
            abilities: [{ type: 'no_buy' }],
          },
          {
            name: 'D&H Private Company',
            sym: 'DPC',
            value: 150,
            revenue: 30,
            desc: 'The owning player gets the President\'s certificate of the D&H corporation, ' \
                  'and must immediately set its stock price. The corporation floats and receives ' \
                  'twice this stock price. This company closes when the D&H ' \
                  'buys a train or with the purchase of the first 12H train.',
            color: nil,
            abilities: [{ type: 'shares', shares: %w[D&H_0] },
                        { type: 'no_buy' },
                        { type: 'close', when: 'bought_train', corporation: 'D&H' }],
          },
        ].freeze

        CORPORATIONS = [
          {
            name: 'Mohawk and Hudson Railroad',
            sym: '1',
            logo: '18_ny/1',
            tokens: [0],
            type: 'minor',
            always_market_price: true,
            shares: [100],
            float_percent: 100,
            max_ownership_percent: 100,
            coordinates: 'F20',
            color: '#000000',
            reservation_color: nil,
          },
          {
            name: 'Utica and Schenectady Railroad',
            sym: '2',
            logo: '18_ny/2',
            tokens: [0],
            type: 'minor',
            always_market_price: true,
            shares: [100],
            float_percent: 100,
            max_ownership_percent: 100,
            coordinates: 'E19',
            color: '#000000',
            reservation_color: nil,
          },
          {
            name: 'Tonawanda Railroad',
            sym: '3',
            logo: '18_ny/3',
            tokens: [0],
            type: 'minor',
            always_market_price: true,
            shares: [100],
            float_percent: 100,
            max_ownership_percent: 100,
            coordinates: 'D8',
            color: '#000000',
            reservation_color: nil,
          },
          {
            name: 'Syracuse and Utica Railroad',
            sym: '4',
            logo: '18_ny/4',
            tokens: [0],
            type: 'minor',
            always_market_price: true,
            shares: [100],
            float_percent: 100,
            max_ownership_percent: 100,
            coordinates: 'E15',
            color: '#000000',
            reservation_color: nil,
          },
          {
            name: 'Auburn and Rochester Railroad',
            sym: '5',
            logo: '18_ny/5',
            tokens: [0],
            type: 'minor',
            always_market_price: true,
            shares: [100],
            float_percent: 100,
            max_ownership_percent: 100,
            coordinates: 'E11',
            color: '#000000',
            reservation_color: nil,
          },
          {
            name: 'Attica and Buffalo Railroad',
            sym: '6',
            logo: '18_ny/6',
            tokens: [0],
            type: 'minor',
            always_market_price: true,
            shares: [100],
            float_percent: 100,
            max_ownership_percent: 100,
            coordinates: 'E3',
            color: '#000000',
            reservation_color: nil,
          },
          {
            name: 'Schenectady and Troy Railroad',
            sym: '7',
            logo: '18_ny/7',
            tokens: [0],
            type: 'minor',
            always_market_price: true,
            shares: [100],
            float_percent: 100,
            max_ownership_percent: 100,
            coordinates: 'E21',
            color: '#000000',
            reservation_color: nil,
          },
          {
            name: 'Rochester, Lockport, and Niagara Falls Railroad',
            sym: '8',
            logo: '18_ny/8',
            tokens: [0],
            type: 'minor',
            always_market_price: true,
            shares: [100],
            float_percent: 100,
            max_ownership_percent: 100,
            coordinates: 'D2',
            color: '#000000',
            reservation_color: nil,
          },
          {
            name: 'Buffalo and Lockport Railroad',
            sym: '9',
            logo: '18_ny/9',
            tokens: [0],
            type: 'minor',
            always_market_price: true,
            shares: [100],
            float_percent: 100,
            max_ownership_percent: 100,
            coordinates: 'D4',
            color: '#000000',
            reservation_color: nil,
          },
          {
            name: 'Rochester and Syracuse Railroad',
            sym: '10',
            logo: '18_ny/10',
            tokens: [0],
            type: 'minor',
            always_market_price: true,
            shares: [100],
            float_percent: 100,
            max_ownership_percent: 100,
            coordinates: 'D12',
            color: '#000000',
            reservation_color: nil,
          },
          {
            name: 'Buffalo and Rochester Railroad',
            sym: '11',
            logo: '18_ny/11',
            tokens: [0],
            type: 'minor',
            always_market_price: true,
            shares: [100],
            float_percent: 100,
            max_ownership_percent: 100,
            coordinates: 'E5',
            color: '#000000',
            reservation_color: nil,
          },
          {
            name: 'Delaware & Hudson Railroad',
            sym: 'D&H',
            logo: '18_ny/dh',
            simple_logo: '18_ny/dh.alt',
            tokens: [0, 20, 20, 20],
            type: 'major',
            always_market_price: true,
            float_percent: 20,
            coordinates: 'H14',
            color: '#2E3192',
            reservation_color: nil,
          },
          {
            name: 'Rome, Watertown, and Ogdensburg Railroad',
            sym: 'RWO',
            logo: '18_ny/rwo',
            simple_logo: '18_ny/rwo.alt',
            tokens: [0, 20, 20, 20],
            type: 'major',
            always_market_price: true,
            float_percent: 20,
            coordinates: 'D14',
            color: '#07733D',
            reservation_color: nil,
          },
          {
            name: 'New York and Harlem Railroad',
            sym: 'NY&H',
            logo: '18_ny/nyh',
            simple_logo: '18_ny/nyh.alt',
            tokens: [0, 20, 20],
            type: 'major',
            always_market_price: true,
            float_percent: 20,
            coordinates: 'J20',
            color: '#8C4776',
            reservation_color: nil,
          },
          {
            name: 'New York, New Haven, & Hartford Railroad',
            sym: 'NYNH',
            logo: '18_ny/nynh',
            simple_logo: '18_ny/nynh.alt',
            tokens: [0, 20, 20],
            type: 'major',
            always_market_price: true,
            float_percent: 20,
            coordinates: 'I25',
            color: '#E96B21',
            reservation_color: nil,
          },
          {
            name: 'Erie Railroad',
            sym: 'ERIE',
            logo: '18_ny/erie',
            simple_logo: '18_ny/erie.alt',
            tokens: [0, 20, 20, 20],
            type: 'major',
            always_market_price: true,
            float_percent: 20,
            coordinates: 'E3',
            color: '#FFF200',
            text_color: 'black',
            reservation_color: nil,
          },
          {
            name: 'Boston and Albany Railroad',
            sym: 'B&A',
            logo: '18_ny/ba',
            simple_logo: '18_ny/ba.alt',
            tokens: [0, 20, 20],
            type: 'major',
            always_market_price: true,
            float_percent: 20,
            coordinates: 'F26',
            color: '#E21F27',
            reservation_color: nil,
          },
          {
            name: 'Hudson River Railroad',
            sym: 'HR',
            logo: '18_ny/hr',
            simple_logo: '18_ny/hr.alt',
            tokens: [0, 20, 20],
            type: 'major',
            always_market_price: true,
            float_percent: 20,
            coordinates: 'H20',
            color: '#8DD8F8',
            text_color: 'black',
            reservation_color: nil,
          },
          {
            name: 'New York Central Railroad',
            sym: 'NYC',
            logo: '18_ny/nyc',
            simple_logo: '18_ny/nyc.alt',
            tokens: [20, 20],
            type: 'major',
            always_market_price: true,
            floatable: false,
            color: '#231F20',
            reservation_color: nil,
          },
        ].freeze
      end
    end
  end
end
