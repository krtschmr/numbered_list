class ListItem
	attr_accessor :title, :level, :prefix

	def initialize(title, level, prefix)
		self.title = title
		self.level = level
		self.prefix = prefix
	end

	def render
		pfx = "#{prefix.join('.')}. "
		tabs = '  ' * level

		[tabs, pfx, title].join
	end
end