# Numbered List

[![codecov](https://codecov.io/gh/krtschmr/numbered_list/branch/main/graph/badge.svg?token=DXMPVMXOAN)](https://codecov.io/gh/krtschmr/numbered_list)


Formats a collection of headlines with keys `title` and `heading_level`. The output simulates the behavior of LibreOffice.


### Installation

Just add

`gem "numbered_list", github: "krtschmr/numbered_list"`

### Usage

Easy usage: 

`NumberedList.render(list)`


### Example
	headlines = [
		{ id: 1, title: 'Heading1', heading_level: 0 },
		{ id: 2, title: 'Heading2', heading_level: 1 },
		{ id: 3, title: 'Heading3', heading_level: 1 },
		{ id: 4, title: 'Heading4', heading_level: 1 }
		{ id: 5, title: 'Heading5', heading_level: 0 }
	]

    NumberedList.render(headlines)
	
	# Produced output: 
    # ----------------
	# 1. Heading1
	#   1.1. Heading2
	#   1.2. Heading3
	#   1.3. Heading4
	# 2. Heading5


