note
	component:   "openEHR ADL Tools"
	description: "Persistent form of archetype used for standard serialisations"
	keywords:    "archetype, persistence"
	author:      "Thomas Beale <thomas.beale@oceaninformatics.com>"
	support:     "http://www.openehr.org/issues/browse/AWB"
	copyright:   "Copyright (c) 2011- Ocean Informatics Pty Ltd <http://www.oceaninfomatics.com>"
	license:     "Apache 2.0 License <http://www.apache.org/licenses/LICENSE-2.0.html>"

class P_ARCHETYPE

inherit
	AUTHORED_RESOURCE

	DT_CONVERTIBLE

create
	make, make_dt

feature -- Initialisation

	make_dt (make_args: detachable ARRAY[ANY])
			-- basic make routine to guarantee validity on creation
		do
		end

	make (an_archetype: ARCHETYPE)
			-- basic make routine to guarantee validity on creation
		do
			artefact_object_type := an_archetype.generating_type

			make_from_other (an_archetype)

			create archetype_id.make (an_archetype.archetype_id)

			adl_version := an_archetype.adl_version
			artefact_type := an_archetype.artefact_type.type_name

			if attached an_archetype.parent_archetype_id as att_pid then
				create parent_archetype_id.make (att_pid)
			end

			is_generated := an_archetype.is_generated

			if attached an_archetype.uid as uv then
				uid := uv.value
			end

			other_metadata := an_archetype.other_metadata

			create definition.make (an_archetype.definition)

			invariants := an_archetype.invariants

			create ontology.make (an_archetype.ontology)

			if attached {OPERATIONAL_TEMPLATE} an_archetype as opt and then attached opt.component_ontologies then
				create component_ontologies.make(0)
				across opt.component_ontologies as opt_comp_onts_csr loop
					component_ontologies.put (create {P_ARCHETYPE_ONTOLOGY}.make (opt_comp_onts_csr.item), opt_comp_onts_csr.key)
				end
			end
		end

feature -- Access

	artefact_object_type: detachable STRING
			-- records object model type of the original artefact

	archetype_id: detachable P_ARCHETYPE_HRID

	other_metadata: detachable HASH_TABLE [STRING, STRING]

	adl_version: detachable STRING
			-- ADL version of this archetype

	artefact_type: detachable STRING
			-- design type of artefact, archetype, template, template-component, etc

	parent_archetype_id: detachable P_ARCHETYPE_HRID
			-- id of specialisation parent of this archetype

	uid: detachable STRING

	definition: detachable P_C_COMPLEX_OBJECT

	invariants: detachable ARRAYED_LIST [ASSERTION]

	ontology: detachable P_ARCHETYPE_ONTOLOGY

	component_ontologies: detachable HASH_TABLE [P_ARCHETYPE_ONTOLOGY, STRING]

feature -- Status Report

	is_generated: BOOLEAN

	has_path (a_path: STRING): BOOLEAN
			-- True if `a_path' is found in resource; define in descendants
		do
		end

feature -- Factory

	create_archetype: detachable ARCHETYPE
		local
			o_parent_archetype_id, o_archetype_id: detachable ARCHETYPE_HRID
			o_diff_arch_ont: DIFFERENTIAL_ARCHETYPE_ONTOLOGY
			o_flat_arch_ont: FLAT_ARCHETYPE_ONTOLOGY
			o_artefact_type: ARTEFACT_TYPE
			o_uid: detachable HIER_OBJECT_ID
		do
			if attached parent_archetype_id as att_pid then
				create o_parent_archetype_id.make_from_string (att_pid.physical_id)
			end

			if attached archetype_id as att_aid
				and attached artefact_type as at
				and attached adl_version as o_adl_version
				and attached original_language as o_original_language
				and attached description as o_description
				and attached definition as o_definition and attached ontology as ont
			then
				create o_archetype_id.make_from_string (att_aid.physical_id)
				create o_artefact_type.make_from_type_name (at)
				if attached uid as att_uid then
					create o_uid.make_from_string (att_uid)
				end

				if artefact_object_type.same_string ("DIFFERENTIAL_ARCHETYPE") then
					create o_diff_arch_ont.make (original_language.as_string, o_definition.node_id)
					ont.populate_ontology (o_diff_arch_ont)
					o_diff_arch_ont.finalise_dt

					create {DIFFERENTIAL_ARCHETYPE} Result.make_all (
						o_artefact_type,
						o_adl_version,
						o_archetype_id,
						o_parent_archetype_id,
						is_controlled,
						o_uid,
						other_metadata,
						o_original_language,
						translations,
						o_description,
						o_definition.create_c_complex_object,
						invariants,
						o_diff_arch_ont,
						annotations
					)

				else
					create o_flat_arch_ont.make (original_language.as_string, o_definition.node_id)
					ont.populate_ontology (o_flat_arch_ont)
					o_flat_arch_ont.finalise_dt

					create {FLAT_ARCHETYPE} Result.make_all (
						o_artefact_type,
						o_adl_version,
						o_archetype_id,
						o_parent_archetype_id,
						is_controlled,
						o_uid,
						other_metadata,
						o_original_language,
						translations,
						o_description,
						o_definition.create_c_complex_object,
						invariants,
						o_flat_arch_ont,
						annotations
					)
				end

				if is_generated then
					Result.set_is_generated
				end
			end
		end

feature {DT_OBJECT_CONVERTER} -- Conversion

	persistent_attributes: detachable ARRAYED_LIST [STRING]
			-- list of attribute names to persist as DT structure
			-- empty structure means all attributes
		do
		end

end


