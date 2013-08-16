note
	component:   "openEHR ADL Tools"
	description: "Perform post parse construction of the AOM structure."
	keywords:    "constraint model"
	author:      "Thomas Beale <thomas.beale@oceaninformatics.com>"
	support:     "http://www.openehr.org/issues/browse/AWB"
	copyright:   "Copyright (c) 2012- Ocean Informatics Pty Ltd <http://www.oceaninfomatics.com>"
	license:     "Apache 2.0 License <http://www.apache.org/licenses/LICENSE-2.0.html>"

class AOM_POST_PARSE_PROCESSOR

inherit
	ADL_SYNTAX_CONVERTER
		export
			{NONE} all;
			{ANY} deep_copy, deep_twin, is_deep_equal, standard_is_equal
		end

	SHARED_AOM_PROFILES_ACCESS
		export
			{NONE} all;
		end

create
	make

feature {ADL15_ENGINE} -- Initialisation

	make (ara: ARCH_CAT_ARCHETYPE; an_rm_schema: BMM_SCHEMA)
			-- set target_descriptor
			-- initialise reporting variables
		require
			ara.compilation_state >= {COMPILATION_STATES}.Cs_parsed
		do
			create att_c_terminology_code_type_mapping
			
			rm_schema := an_rm_schema
			set_domain_type_mappings

			target_descriptor := ara
			check attached ara.differential_archetype as diff_arch then
				target := diff_arch
			end
			if ara.is_specialised then
				arch_parent_flat := target_descriptor.specialisation_parent.flat_archetype
			end
		ensure
			target_descriptor_set: target_descriptor = ara
			target_set: attached target
		end

	initialise (ara: ARCH_CAT_ARCHETYPE; an_rm_schema: BMM_SCHEMA)
			-- set target_descriptor
			-- initialise reporting variables
		require
			ara.compilation_state >= {COMPILATION_STATES}.Cs_parsed
		do
			if rm_schema /= an_rm_schema then
				rm_schema := an_rm_schema
				set_domain_type_mappings
			end
			target_descriptor := ara
			check attached ara.differential_archetype as diff_arch then
				target := diff_arch
			end
			if ara.is_specialised then
				arch_parent_flat := target_descriptor.specialisation_parent.flat_archetype
			end
		ensure
			target_descriptor_set: target_descriptor = ara
			target_set: attached target
		end

feature -- Access

	target_descriptor: ARCH_CAT_ARCHETYPE
			-- differential archetype being validated

	target: DIFFERENTIAL_ARCHETYPE
			-- differential archetype being processed

	arch_parent_flat: detachable FLAT_ARCHETYPE

	rm_schema: BMM_SCHEMA

feature -- Commands

	execute
		do
			update_constraint_refs
			update_aom_mapped_types
		end

	clear
		do
			c_terminology_code_type_mapping := Void
		end

feature {NONE} -- Implementation

	update_constraint_refs
			-- populate CONSTRAINT_REF rm_type_name based on RM schema
		local
			bmm_prop_def: BMM_PROPERTY_DEFINITION
			proximal_ca: C_ATTRIBUTE
			proximal_co: C_COMPLEX_OBJECT
			apa: ARCHETYPE_PATH_ANALYSER
		do
			across target.accodes_index as ac_codes_csr loop
				across ac_codes_csr.item as cref_list_csr loop
					check attached cref_list_csr.item.parent as p then
						proximal_ca := p
					end
					if proximal_ca.has_differential_path then
						check attached proximal_ca.differential_path as diff_path then
							create apa.make_from_string (diff_path)
						end
						check attached {C_COMPLEX_OBJECT} arch_parent_flat.c_object_at_path (apa.path_at_level (arch_parent_flat.specialisation_depth)) as cco then
							proximal_co := cco
						end
					else
						check attached proximal_ca.parent as p then
							proximal_co := p
						end
					end
					bmm_prop_def := rm_schema.property_definition (proximal_co.rm_type_name, proximal_ca.rm_attribute_name)
					cref_list_csr.item.set_rm_type_name (bmm_prop_def.type.root_class)
				end
			end
		end

	update_aom_mapped_types
			-- Find any types that have a AOM profile type mapping and write the
			-- mapping in
		local
			def_it: C_ITERATOR
		do
			if attached c_terminology_code_type_mapping as ctc_tm then
				att_c_terminology_code_type_mapping := ctc_tm
				create def_it.make (target.definition)
				def_it.do_all (agent update_aom_mapped_type, Void)
			end
		end

	update_aom_mapped_type (a_c_node: ARCHETYPE_CONSTRAINT; depth: INTEGER)
			-- perform validation of node against reference model.
		do
			if attached {C_PRIMITIVE_OBJECT} a_c_node as cpo and then attached {C_TERMINOLOGY_CODE} cpo.item as ctc then
				cpo.set_rm_type_name (att_c_terminology_code_type_mapping.target_class_name)
				ctc.set_rm_type_name (att_c_terminology_code_type_mapping.target_class_name)
				ctc.set_rm_type_mapping (att_c_terminology_code_type_mapping)
			end
		end

	set_domain_type_mappings
		local
			aom_profile: AOM_PROFILE
		do
			-- find out if any mappings exist in an AOM_PROFILE
			if aom_profiles_access.has_profile_for_rm_schema (rm_schema.schema_id) then
				aom_profile := aom_profiles_access.profile_for_rm_schema (rm_schema.schema_id)
				if attached aom_profile.aom_rm_type_mappings as aom_tm then
					if aom_tm.has (bare_type_name (({TERMINOLOGY_CODE}).name)) then
						c_terminology_code_type_mapping := aom_tm.item (bare_type_name (({TERMINOLOGY_CODE}).name))
					else
						c_terminology_code_type_mapping := Void
					end
				else
					clear
				end
			else
				clear
			end
		end

	c_terminology_code_type_mapping: detachable AOM_TYPE_MAPPING

	att_c_terminology_code_type_mapping: AOM_TYPE_MAPPING
			-- logically attached version of c_terminology_code_type_mapping

end


