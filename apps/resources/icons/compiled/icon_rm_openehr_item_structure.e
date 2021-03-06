note
	description: "Icon loader class generated by icondbc"
	keywords:    "Embedded icons"
	author:      "Thomas Beale <thomas.beale@oceaninformatics.com>"
	support:     "http://www.openehr.org/issues/browse/AWB"
	copyright:   "Copyright (c) 2013- Ocean Informatics Pty Ltd"
	license:     "Apache 2.0 License <http://www.apache.org/licenses/LICENSE-2.0.html>"

class ICON_RM_OPENEHR_ITEM_STRUCTURE

inherit
	ICON_SOURCE

create
	make

feature {NONE} -- Initialization

	make
			-- Initialization
		do
			key := "rm/openehr/item_structure"
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
					A(00,00,00,00) A(00,00,00,00) A(00,00,00,00) A(FF,FF,C9,FF) A(00,00,00,00) A(00,00,00,00) A(00,00,00,00) A(00,00,00,00) A(00,00,00,00) A(00,00,00,00) 
					A(00,00,00,00) A(00,00,00,00) A(00,00,00,00) A(00,00,00,00) A(00,00,00,00) A(00,00,00,00) A(00,00,00,00) A(FF,FF,BE,FE) A(FF,BB,63,B8) A(FF,DA,6A,B2) 
					A(FF,9A,47,96) A(FF,FF,EE,FF) A(00,00,00,00) A(00,00,00,00) A(00,00,00,00) A(00,00,00,00) A(00,00,00,00) A(00,00,00,00) A(00,00,00,00) A(00,00,00,00) 
					A(00,00,00,00) A(00,00,00,00) A(00,00,00,00) A(FF,BC,59,A8) A(FF,E6,E6,E6) A(FF,E6,E6,E6) A(FF,C0,C0,C0) A(FF,97,3B,7C) A(00,00,00,00) A(00,00,00,00) 
					A(00,00,00,00) A(00,00,00,00) A(00,00,00,00) A(00,00,00,00) A(00,00,00,00) A(00,00,00,00) A(00,00,00,00) A(00,00,00,00) A(00,00,00,00) A(FF,DC,46,7D) 
					A(FF,DE,DE,DE) A(FF,FF,FF,FF) A(FF,DE,DE,DE) A(FF,A6,31,6B) A(FF,FF,EE,FF) A(00,00,00,00) A(00,00,00,00) A(00,00,00,00) A(00,00,00,00) A(00,00,00,00) 
					A(00,00,00,00) A(00,00,00,00) A(00,00,00,00) A(00,00,00,00) A(00,00,00,00) A(FF,B6,3E,7E) A(FF,C0,C0,C0) A(FF,DE,DE,DE) A(FF,C0,C0,C0) A(FF,A9,42,7D) 
					A(00,00,00,00) A(00,00,00,00) A(00,00,00,00) A(00,00,00,00) A(00,00,00,00) A(00,00,00,00) A(00,00,00,00) A(00,00,00,00) A(00,00,00,00) A(00,00,00,00) 
					A(00,00,00,00) A(FF,E5,94,DA) A(FF,C2,4E,91) A(FF,B9,30,6D) A(FF,B2,48,89) A(FF,FF,AF,EE) A(00,00,00,00) A(00,00,00,00) A(00,00,00,00) A(FF,FF,BE,FE) 
					A(FF,BB,63,B8) A(FF,DA,6A,B2) A(FF,9A,47,96) A(FF,FF,EE,FF) A(00,00,00,00) A(00,00,00,00) A(00,00,00,00) A(00,00,00,00) A(FF,E4,82,B6) A(FF,C8,66,9A) 
					A(FF,FF,EA,FF) A(00,00,00,00) A(00,00,00,00) A(00,00,00,00) A(00,00,00,00) A(FF,BC,59,A8) A(FF,E6,E6,E6) A(FF,E6,E6,E6) A(FF,C0,C0,C0) A(FF,97,3B,7C) 
					A(00,00,00,00) A(00,00,00,00) A(00,00,00,00) A(00,00,00,00) A(FF,E5,83,B7) A(FF,BD,5B,8F) A(FF,9B,39,6D) A(FF,9E,3C,70) A(FF,9E,3C,70) A(FF,9E,3C,70) 
					A(FF,9E,3C,70) A(FF,DC,46,7D) A(FF,DE,DE,DE) A(FF,FF,FF,FF) A(FF,DE,DE,DE) A(FF,A6,31,6B) A(00,00,00,00) A(00,00,00,00) A(00,00,00,00) A(00,00,00,00) 
					A(FF,FF,A5,D9) A(FF,B9,57,8B) A(FF,F1,8F,C3) A(FF,E1,7F,B3) A(FF,E1,7F,B3) A(FF,E1,7F,B3) A(FF,E8,84,B6) A(FF,B6,3E,7E) A(FF,C0,C0,C0) A(FF,DE,DE,DE) 
					A(FF,C0,C0,C0) A(FF,A9,42,7D) A(00,00,00,00) A(00,00,00,00) A(00,00,00,00) A(00,00,00,00) A(FF,FF,B3,E7) A(FF,C3,61,95) A(FF,FF,DE,FF) A(00,00,00,00) 
					A(00,00,00,00) A(00,00,00,00) A(00,00,00,00) A(FF,E5,94,DA) A(FF,C2,4E,91) A(FF,B9,30,6D) A(FF,B2,48,89) A(FF,FF,AF,EE) A(00,00,00,00) A(00,00,00,00) 
					A(00,00,00,00) A(00,00,00,00) A(FF,FF,B3,E7) A(FF,C3,61,95) A(FF,FF,DE,FF) A(00,00,00,00) A(00,00,00,00) A(00,00,00,00) A(00,00,00,00) A(00,00,00,00) 
					A(00,00,00,00) A(FF,FF,E3,FF) A(00,00,00,00) A(FF,DE,87,C9) A(00,00,00,00) A(00,00,00,00) A(00,00,00,00) A(00,00,00,00) A(FF,FF,B3,E7) A(FF,C3,61,95) 
					A(FF,FF,DE,FF) A(00,00,00,00) A(00,00,00,00) A(00,00,00,00) A(00,00,00,00) A(FF,FF,BE,FE) A(FF,BB,63,B8) A(FF,DA,6A,B2) A(FF,9A,47,96) A(FF,FF,EE,FF) 
					A(00,00,00,00) A(00,00,00,00) A(00,00,00,00) A(00,00,00,00) A(FF,FF,B3,E7) A(FF,C4,62,96) A(FF,FF,DD,FF) A(FF,FF,DF,FF) A(FF,FF,DF,FF) A(FF,FF,DF,FF) 
					A(FF,FF,EE,FF) A(FF,BC,59,A8) A(FF,E6,E6,E6) A(FF,E6,E6,E6) A(FF,C0,C0,C0) A(FF,97,3B,7C) A(00,00,00,00) A(00,00,00,00) A(00,00,00,00) A(00,00,00,00) 
					A(FF,FF,B5,E9) A(FF,B4,52,86) A(FF,8E,2C,60) A(FF,90,2E,62) A(FF,90,2E,62) A(FF,90,2E,62) A(FF,8E,2C,60) A(FF,DC,46,7D) A(FF,DE,DE,DE) A(FF,FF,FF,FF) 
					A(FF,DE,DE,DE) A(FF,A6,31,6B) A(00,00,00,00) A(00,00,00,00) A(00,00,00,00) A(00,00,00,00) A(FF,FF,BB,EF) A(FF,FF,A9,DD) A(FF,FF,AC,E0) A(FF,FF,AC,E0) 
					A(FF,FF,AC,E0) A(FF,FF,AC,E0) A(FF,FF,BD,ED) A(FF,B6,3E,7E) A(FF,C0,C0,C0) A(FF,DE,DE,DE) A(FF,C0,C0,C0) A(FF,A9,42,7D) A(00,00,00,00) A(00,00,00,00) 
					A(00,00,00,00) A(00,00,00,00) A(00,00,00,00) A(00,00,00,00) A(00,00,00,00) A(00,00,00,00) A(00,00,00,00) A(00,00,00,00) A(00,00,00,00) A(FF,E5,94,DA) 
					A(FF,C2,4E,91) A(FF,B9,30,6D) A(FF,B2,48,89) A(FF,FF,AF,EE) A(00,00,00,00) A(00,00,00,00) ;
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