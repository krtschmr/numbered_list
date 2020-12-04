# frozen_string_literal: true

RSpec.describe NumberedList do
  describe 'root headings' do
    it 'renders one' do
      list = [
        { id: 1, title: 'Heading1', heading_level: 0 }
      ]

      expect(NumberedList.render(list)).to eq <<~TEXT.strip
        1. Heading1
      TEXT
    end

    it 'has ongoing indexes' do
      list = [
        { id: 1, title: 'Heading1', heading_level: 0 },
        { id: 2, title: 'Heading2', heading_level: 0 },
        { id: 3, title: 'Heading3', heading_level: 0 },
        { id: 4, title: 'Heading4', heading_level: 0 },
        { id: 5, title: 'Heading5', heading_level: 0 }
      ]

      expect(NumberedList.render(list)).to eq <<~TEXT.strip
        1. Heading1
        2. Heading2
        3. Heading3
        4. Heading4
        5. Heading5
      TEXT
    end
  end

  describe '#indentation' do
    context 'with one child' do
      it 'renders a child one level deeper' do
        list = [
          { id: 1, title: 'Heading1', heading_level: 0 },
          { id: 2, title: 'Heading2', heading_level: 1 }
        ]

        expect(NumberedList.render(list)).to eq <<~TEXT.strip
          1. Heading1
            1.1. Heading2
        TEXT
      end

      context 'skipping certain levels' do
        it 'indents to the second level and skipped level 1' do
          list = [
            { id: 1, title: 'Heading1', heading_level: 0 },
            { id: 2, title: 'Heading2', heading_level: 2 }
          ]
          expect(NumberedList.render(list)).to eq <<~TEXT.strip
            1. Heading1
                1.1.1. Heading2
          TEXT
        end

        it 'indents to level 4 and skipped level 1-4' do
          list = [
            { id: 1, title: 'Heading1', heading_level: 0 },
            { id: 2, title: 'Heading2', heading_level: 5 }
          ]
          expect(NumberedList.render(list)).to eq <<~TEXT.strip
            1. Heading1
                      1.1.1.1.1.1. Heading2
          TEXT
        end

        it 'skips level 3 and 4' do
          list = [
            { id: 1, title: 'Heading1', heading_level: 0 },
            { id: 2, title: 'Heading2', heading_level: 1 },
            { id: 3, title: 'Heading3', heading_level: 2 },
            { id: 4, title: 'Heading4', heading_level: 5 }
          ]

          expect(NumberedList.render(list)).to eq <<~TEXT.strip
            1. Heading1
              1.1. Heading2
                1.1.1. Heading3
                      1.1.1.1.1.1. Heading4
          TEXT
        end
      end
    end

    context 'with multiple childs' do
      it 'has ongoing index for the children' do
        list = [
          { id: 1, title: 'Heading1', heading_level: 0 },
          { id: 2, title: 'Heading2', heading_level: 1 },
          { id: 3, title: 'Heading3', heading_level: 1 },
          { id: 4, title: 'Heading4', heading_level: 1 }
        ]

        expect(NumberedList.render(list)).to eq <<~TEXT.strip
          1. Heading1
            1.1. Heading2
            1.2. Heading3
            1.3. Heading4
        TEXT
      end
    end
  end

  it 'renders 2 roots with each having a child who has a child' do
    list = [
      { id: 1, title: 'Heading1', heading_level: 0 },
      { id: 2, title: 'Heading2', heading_level: 1 },
      { id: 3, title: 'Heading3', heading_level: 2 },
      { id: 4, title: 'Heading4', heading_level: 0 },
      { id: 5, title: 'Heading5', heading_level: 1 },
      { id: 5, title: 'Heading6', heading_level: 2 }
    ]

    expect(NumberedList.render(list)).to eq <<~TEXT.strip
      1. Heading1
        1.1. Heading2
          1.1.1. Heading3
      2. Heading4
        2.1. Heading5
          2.1.1. Heading6
    TEXT
  end

  it 'indexes a child continuation correct' do
    list = [
      { id: 1, title: 'Heading1', heading_level: 0 },
      { id: 2, title: 'Heading1.1', heading_level: 1 },
      { id: 3, title: 'Heading2', heading_level: 0 },
      { id: 4, title: 'Heading2.1', heading_level: 1 }
    ]

    expect(NumberedList.render(list)).to eq <<~TEXT.strip
      1. Heading1
        1.1. Heading1.1
      2. Heading2
        2.1. Heading2.1#{'  '}
    TEXT
  end

  it 'indexes within childs correct' do
    list = [
      { id: 1, title: 'Heading1', heading_level: 0 },
      { id: 2, title: 'Heading1.1', heading_level: 1 },
      { id: 3, title: 'Heading1.2', heading_level: 1 },
      { id: 4, title: 'Heading1.3', heading_level: 1 }
    ]

    expect(NumberedList.render(list)).to eq <<~TEXT.strip
      1. Heading1
        1.1. Heading1.1
        1.2. Heading1.2
        1.3. Heading1.3#{'  '}
    TEXT
  end

  it 'indexes deeper childs correct' do
    list = [
      { id: 1, title: 'Heading1', heading_level: 0 },
      { id: 2, title: 'Heading1.1.1', heading_level: 2 },
      { id: 3, title: 'Heading1.1.2', heading_level: 2 },
      { id: 4, title: 'Heading1.1.3', heading_level: 2 }
    ]

    expect(NumberedList.render(list)).to eq <<~TEXT.strip
      1. Heading1
          1.1.1. Heading1.1.1
          1.1.2. Heading1.1.2
          1.1.3. Heading1.1.3
    TEXT
  end

  describe 'coding challenge' do
    it 'is correct for example1' do
      list = [
        { id: 1, title: 'heading1', heading_level: 0 },
        { id: 2, title: 'heading2', heading_level: 2 },
        { id: 3, title: 'heading3', heading_level: 1 },
        { id: 4, title: 'heading4', heading_level: 1 }
      ]
      expect(NumberedList.render(list)).to eq <<~TEXT.strip
        1. heading1
            1.1.1. heading2
          1.2. heading3
          1.3. heading4
      TEXT
    end

    it 'is correct for example2' do
      list = [
        { id: 1, title: 'heading1', heading_level: 0 },
        { id: 2, title: 'heading2', heading_level: 3 },
        { id: 3, title: 'heading3', heading_level: 4 },
        { id: 4, title: 'heading4', heading_level: 1 },
        { id: 5, title: 'heading5', heading_level: 0 }
      ]
      expect(NumberedList.render(list)).to eq <<~TEXT.strip
        1. heading1
              1.1.1.1. heading2
                1.1.1.1.1. heading3
          1.2. heading4
        2. heading5
      TEXT
    end

    it 'is correct for example3' do
      list = [
        { id: 1, title: 'heading1', heading_level: 0 },
        { id: 2, title: 'heading2', heading_level: 1 },
        { id: 3, title: 'heading3', heading_level: 4 },
        { id: 4, title: 'heading4', heading_level: 0 },
        { id: 5, title: 'heading5', heading_level: 4 },
        { id: 6, title: 'heading6', heading_level: 0 },
        { id: 7, title: 'heading7', heading_level: 1 }
      ]
      expect(NumberedList.render(list)).to eq <<~TEXT.strip
        1. heading1
          1.1. heading2
                1.1.1.1.1. heading3
        2. heading4
                2.1.1.1.1. heading5
        3. heading6
          3.1. heading7
      TEXT
    end
  end
end
