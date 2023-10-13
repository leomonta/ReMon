local function clamp(a, b, c)
	return math.min(math.max(a, b), c)
end

local function oklab(L, a, bb)
	local l_ = L + 0.3963377774 * a + 0.2158037573 * bb
	local m_ = L - 0.1055613458 * a - 0.0638541728 * bb
	local s_ = L - 0.0894841775 * a - 1.2914855480 * bb

	local l = l_ * l_ * l_
	local m = m_ * m_ * m_
	local s = s_ * s_ * s_

	local r = ( 4.0767416621 * l - 3.3077115913 * m + 0.2309699292 * s)
	local g = (-1.2684380046 * l + 2.6097574011 * m - 0.3413193965 * s)
	local b = (-0.0041960863 * l - 0.7034186147 * m + 1.7076147010 * s)


	local max, min = math.max(r, g, b), math.min(r, g, b)
	local h = 0

	print(r, g, b)

	r = clamp(r, 0.0, 1.0)
	g = clamp(g, 0.0, 1.0)
	b = clamp(b, 0.0, 1.0)

	print(r, g, b)

	l = (max + min) / 2

	if max == min then
		h, s = 0, 0 -- achromatic
	else
		local d = max - min
		if l > 0.5 then
			s = d / (2 - max - min)
		else
			s = d / (max + min)
		end
		if max == r then
				h = (g - b) / d
			if g < b then
				h = h + 6
			end
		elseif max == g then
			h = (b - r) / d + 2
		elseif max == b then
			h = (r - g) / d + 4
		end
		h = h / 6
	end

	return h, s, l
end

print(oklab(0.5, 0.3, 0.3))
