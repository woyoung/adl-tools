note
	description: "Icon loader class generated by icondbc"
	keywords:    "Embedded icons"
	author:      "Thomas Beale <thomas.beale@oceaninformatics.com>"
	support:     "http://www.openehr.org/issues/browse/AWB"
	copyright:   "Copyright (c) 2013- Ocean Informatics Pty Ltd"
	license:     "See notice at bottom of class"

class ICON_RM_OPENEHR_DV_BOOLEAN

inherit
	ICON_SOURCE

create
	make

feature {NONE} -- Initialization

	make
			-- Initialization
		do
			key := "rm/openehr/dv_boolean"
			make_with_size (16, 16)
			fill_memory
		end

feature {NONE} -- Image data
	
	c_colors_0 (a_ptr: POINTER; a_offset: INTEGER)
			-- Fill `a_ptr' with colors data from `a_offset'.
		external
			"C inline"
		alias
			"{
				{
					#define B(q) #q
					#ifdef EIF_WINDOWS
						#define A(a,r,g,b) B(\x##b\x##g\x##r\x##a)
					#else
						#define A(a,r,g,b) B(\x##r\x##g\x##b\x##a)
					#endif

					char l_data[] =
					A(00,00,00,00) A(00,00,00,00) A(00,00,00,00) A(00,00,00,00) A(00,00,00,00) A(00,00,00,00) A(00,00,00,00) A(00,00,00,00) A(00,00,00,00) A(00,BE,D1,96) 
					A(00,00,00,00) A(57,B7,CC,8C) A(00,00,00,00) A(00,00,00,00) A(00,00,00,00) A(00,00,00,00) A(00,00,00,00) A(00,00,00,00) A(00,00,00,00) A(00,00,00,00) 
					A(00,00,00,00) A(00,00,00,00) A(00,00,00,00) A(00,00,00,00) A(00,A7,C0,72) A(06,BD,CD,98) A(E5,A4,BF,6E) A(FF,97,B5,5A) A(03,FF,FF,FF) A(00,00,00,00) 
					A(00,00,00,00) A(00,00,00,00) A(00,00,00,00) A(00,00,00,00) A(00,00,00,00) A(00,00,00,00) A(00,00,00,00) A(00,00,00,00) A(00,00,00,00) A(00,AE,C5,7E) 
					A(06,B5,C7,88) A(E8,A0,BC,67) A(FE,9F,BB,65) A(EB,97,B5,5B) A(00,00,00,00) A(00,00,00,00) A(00,00,00,00) A(00,00,00,00) A(00,BA,CE,91) A(00,00,00,00) 
					A(00,00,00,00) A(00,AD,C5,7C) A(00,00,00,00) A(00,00,00,00) A(00,BB,CF,93) A(12,D6,E3,C1) A(EA,A1,BC,68) A(FE,9F,BB,65) A(FF,95,B3,59) A(2E,AD,C4,7E) 
					A(00,00,00,00) A(00,00,00,00) A(00,00,00,00) A(00,00,00,00) A(0F,C6,D6,A4) A(E2,A5,BF,6F) A(FF,A0,BB,68) A(00,FF,FF,FF) A(00,00,00,00) A(00,BF,D1,97) 
					A(12,D8,E3,C1) A(F2,A3,BD,6C) A(FE,9F,BB,65) A(FF,97,B5,5C) A(30,9B,B9,62) A(00,00,00,00) A(00,00,00,00) A(00,00,00,00) A(00,00,00,00) A(00,00,00,00) 
					A(AB,A6,C0,70) A(FE,C6,DA,9F) A(FF,AA,C4,76) A(38,9E,B9,67) A(00,BE,D1,97) A(16,D7,E1,BD) A(F8,A4,BE,6D) A(FE,9F,BB,65) A(FF,96,B5,5A) A(48,AC,C4,7D) 
					A(00,00,00,00) A(00,00,00,00) A(00,00,00,00) A(00,00,00,00) A(00,00,00,00) A(00,00,00,00) A(BF,A4,BF,6F) A(FF,D5,E4,B3) A(FF,AB,C5,77) A(67,A6,BF,72) 
					A(16,CF,DE,B0) A(F8,A3,BE,6D) A(FE,9F,BB,65) A(FF,96,B4,59) A(46,9B,CE,75) A(00,00,00,00) A(00,00,00,00) A(00,00,00,00) A(00,00,00,00) A(00,00,00,00) 
					A(00,00,00,00) A(00,00,00,00) A(B8,A5,BF,6F) A(FF,D0,E1,AD) A(FE,B5,CD,86) A(E0,A1,BC,68) A(F6,A0,BC,68) A(FE,9F,BB,65) A(FF,97,B5,5B) A(86,B2,9E,68) 
					A(EF,B8,0D,0D) A(58,5C,37,37) A(00,00,00,00) A(00,00,00,00) A(00,CC,51,51) A(00,00,00,00) A(23,9A,43,43) A(00,65,3D,3D) A(A0,A6,C0,70) A(FF,C0,D5,96) 
					A(FF,C4,D8,9C) A(FF,9D,B9,62) A(FF,9F,BB,65) A(FF,98,B5,5B) A(6A,A0,BC,6B) A(4D,9C,2D,32) A(FF,B9,00,00) A(FF,87,03,03) A(1B,63,66,66) A(00,00,00,00) 
					A(1B,CC,7A,7A) A(E2,CF,0B,0B) A(F5,80,0A,0A) A(07,72,C2,C2) A(76,A7,C0,72) A(FF,9F,BB,66) A(FF,A4,BF,6D) A(FE,9F,BB,65) A(FF,98,B5,5D) A(6B,A2,BD,6E) 
					A(00,00,00,00) A(00,00,00,00) A(93,99,24,24) A(FF,C2,00,00) A(E6,73,0D,0D) A(4C,C7,32,32) A(FF,CE,04,04) A(FF,AE,00,00) A(DE,8C,19,19) A(1A,B6,70,70) 
					A(13,B3,C9,85) A(FB,9C,B8,60) A(FF,9D,BA,62) A(FF,94,B3,58) A(49,9D,B9,65) A(00,00,00,00) A(00,00,00,00) A(00,00,00,00) A(00,00,00,00) A(D4,A1,1A,1A) 
					A(FE,B8,00,00) A(FF,C5,00,00) A(FF,98,00,00) A(A1,94,30,30) A(00,00,00,00) A(00,C9,78,78) A(00,9A,B7,60) A(09,DD,E7,C9) A(77,9D,B9,66) A(1A,B9,CE,92) 
					A(00,00,00,00) A(00,00,00,00) A(00,00,00,00) A(00,F4,00,00) A(0E,BD,6F,6F) A(D0,CB,0B,0B) A(FF,C3,00,00) A(FF,AC,00,00) A(97,77,2C,2C) A(00,00,00,00) 
					A(00,00,00,00) A(00,00,00,00) A(00,00,00,00) A(00,00,00,00) A(00,00,00,00) A(00,00,00,00) A(00,00,00,00) A(00,00,00,00) A(00,00,00,00) A(44,C7,38,38) 
					A(FF,CE,07,07) A(FF,B3,00,00) A(E1,86,13,13) A(FF,B8,02,02) A(FF,8E,07,07) A(23,57,4E,4E) A(00,6A,44,44) A(00,00,00,00) A(00,00,00,00) A(00,00,00,00) 
					A(00,00,00,00) A(00,00,00,00) A(00,00,00,00) A(00,00,00,00) A(26,A7,54,54) A(FF,C0,01,01) A(FF,9B,00,00) A(B0,92,2E,2E) A(00,00,00,00) A(84,9A,2A,2A) 
					A(FF,C1,00,00) A(F0,78,0C,0C) A(00,00,00,00) A(00,66,40,40) A(00,00,00,00) A(00,00,00,00) A(00,00,00,00) A(00,00,00,00) A(00,00,00,00) A(00,00,00,00) 
					A(00,00,00,00) A(9A,9A,29,29) A(63,9F,44,44) A(00,00,00,00) A(00,F3,DE,DE) A(00,00,00,00) A(C7,9F,13,13) A(FF,9F,00,00) A(7F,83,3A,3A) A(00,00,00,00) 
					A(00,00,00,00) A(00,00,00,00) A(00,00,00,00) A(00,00,00,00) A(00,00,00,00) A(00,00,00,00) A(00,00,00,00) A(00,00,00,00) A(00,00,00,00) A(00,00,00,00) 
					A(00,00,00,00) A(00,B3,74,74) A(0A,AE,9A,9A) A(73,A4,44,44) A(00,00,00,00) A(00,F0,DE,DE) ;
					memcpy ((EIF_NATURAL_32 *)$a_ptr + $a_offset, &l_data, sizeof l_data - 1);
				}
			}"
		end

	build_colors (a_ptr: POINTER)
			-- Build `colors'
		do
			c_colors_0 (a_ptr, 0)
		end

end