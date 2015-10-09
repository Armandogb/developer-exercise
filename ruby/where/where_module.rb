class Array

	def where(condition)
		array_copy = self.dup

		condition.each do |k,v|
			if v.class == Regexp
				array_copy.reject! { |obj| !v.match(obj[k]) }
			else
				array_copy.reject! { |obj| obj[k] != v }
			end
		end
		return array_copy
	end

end

