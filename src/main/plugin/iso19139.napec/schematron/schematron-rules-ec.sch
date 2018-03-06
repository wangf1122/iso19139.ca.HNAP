<?xml version="1.0" encoding="UTF-8"?>
<sch:schema xmlns:sch="http://purl.oclc.org/dsdl/schematron"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform" queryBinding="xslt2">

    <sch:title xmlns="http://www.w3.org/2001/XMLSchema">NAPEC validation rules for internal publication</sch:title>
    <sch:ns prefix="gml" uri="http://www.opengis.net/gml/3.2"/>
    <sch:ns prefix="gmd" uri="http://www.isotc211.org/2005/gmd"/>
    <sch:ns prefix="srv" uri="http://www.isotc211.org/2005/srv"/>
    <sch:ns prefix="gco" uri="http://www.isotc211.org/2005/gco"/>
    <sch:ns prefix="geonet" uri="http://www.fao.org/geonetwork"/>
    <sch:ns prefix="xlink" uri="http://www.w3.org/1999/xlink"/>
    <sch:ns prefix="rdf" uri="http://www.w3.org/1999/02/22-rdf-syntax-ns#"/>
    <sch:ns prefix="ns2" uri="http://www.w3.org/2004/02/skos/core#"/>
    <sch:ns prefix="rdfs" uri="http://www.w3.org/2000/01/rdf-schema#"/>

  <!-- =============================================================
  EC schematron rules:
  ============================================================= -->
    <sch:pattern>
        <sch:title>$loc/strings/EC1</sch:title>

        <sch:rule context="//gmd:contact/*/gmd:organisationName">
          <sch:let name="missing" value="not(string(gco:CharacterString))
              or (@gco:nilReason)" />

          <sch:let name="missingOtherLang" value="not(string(gmd:PT_FreeText/gmd:textGroup/gmd:LocalisedCharacterString))" />

          <sch:assert
            test="not($missing and $missingOtherLang)"
            >$loc/strings/EC1</sch:assert>
        </sch:rule>
    </sch:pattern>

    <sch:pattern>
      <sch:title>$loc/strings/EC26</sch:title>

      <sch:rule context="//gmd:contact/*/gmd:organisationName">
        <sch:let name="government-titles" value="document(concat('file:///', $thesaurusDir, '/local/thesauri/theme/EC_Government_Titles.rdf'))"/>

        <sch:let name="organisationName" value="gco:CharacterString" />
        <sch:let name="isGovernmentOfCanada" value="starts-with(lower-case($organisationName), 'government of canada') or starts-with(lower-case($organisationName), 'gouvernement du canada')" />
        <sch:let name="titleName" value="lower-case(normalize-space(tokenize($organisationName, ';')[2]))" />

        <sch:assert test="not($isGovernmentOfCanada) or
                ($isGovernmentOfCanada and (string($government-titles//rdf:Description[normalize-space(lower-case(ns2:prefLabel[@xml:lang='en'])) = $titleName]) or
                string($government-titles//rdf:Description[normalize-space(lower-case(ns2:prefLabel[@xml:lang='fr'])) = $titleName]))
                )">$loc/strings/EC26</sch:assert>


        <sch:let name="organisationNameOtherLang" value="gmd:PT_FreeText/gmd:textGroup/gmd:LocalisedCharacterString" />
        <sch:let name="isGovernmentOfCanadaOtherLang" value="starts-with(lower-case($organisationNameOtherLang), 'government of canada') or starts-with(lower-case($organisationNameOtherLang), 'gouvernement du canada')" />
        <sch:let name="titleNameOtherLang" value="lower-case(normalize-space(tokenize($organisationNameOtherLang, ';')[2]))" />

        <sch:assert test="not($isGovernmentOfCanadaOtherLang) or
                ($isGovernmentOfCanadaOtherLang and (string($government-titles//rdf:Description[normalize-space(lower-case(ns2:prefLabel[@xml:lang='en'])) = $titleNameOtherLang]) or
                string($government-titles//rdf:Description[normalize-space(lower-case(ns2:prefLabel[@xml:lang='fr'])) = $titleNameOtherLang]))
                )">$loc/strings/EC26</sch:assert>
      </sch:rule>
    </sch:pattern>

   <sch:pattern>
      <sch:title>$loc/strings/ECCountry</sch:title>

       <sch:rule context="//gmd:contact//gmd:country">
        <sch:let name="country-values" value="document(concat('file:///', $thesaurusDir, '/local/thesauri/theme/EC_ISO_Countries.rdf'))"/>

        <sch:let name="countryName" value="lower-case(gco:CharacterString)" />
        <sch:let name="countryNameOtherLang" value="lower-case(gmd:PT_FreeText/gmd:textGroup/gmd:LocalisedCharacterString)" />

         <sch:assert test="(not($countryName) or
           ($countryName and (string($country-values//rdf:Description[lower-case(normalize-space(ns2:prefLabel[@xml:lang='en'])) = $countryName]) or
           string($country-values//rdf:Description[lower-case(normalize-space(ns2:prefLabel[@xml:lang='fr'])) = $countryName]))))

           and

           (not($countryNameOtherLang) or
                       ($countryNameOtherLang and (string($country-values//rdf:Description[lower-case(normalize-space(ns2:prefLabel[@xml:lang='en'])) = $countryNameOtherLang]) or
                       string($country-values//rdf:Description[lower-case(normalize-space(ns2:prefLabel[@xml:lang='fr'])) = $countryNameOtherLang]))
                       ))">$loc/strings/ECCountry</sch:assert>


      </sch:rule>
    </sch:pattern>

    <sch:pattern>
            <sch:title>$loc/strings/EC1</sch:title>

            <sch:rule context="//gmd:identificationInfo/gmd:citation/*/gmd:citedResponsibleParty/*/gmd:organisationName
                       |//*[@gco:isoType='gmd:MD_DataIdentification']/gmd:citation/*/gmd:citedResponsibleParty/*/gmd:organisationName
                       |//*[@gco:isoType='srv:SV_ServiceIdentification']/gmd:citation/*/gmd:citedResponsibleParty/*/gmd:organisationName">

                <sch:let name="missing" value="not(string(gco:CharacterString))
                    or (@gco:nilReason)" />

                <sch:let name="missingOtherLang" value="not(string(gmd:PT_FreeText/gmd:textGroup/gmd:LocalisedCharacterString))" />

                <sch:assert
                    test="not($missing and $missingOtherLang)"
                    >$loc/strings/EC1</sch:assert>

            </sch:rule>
    </sch:pattern>

    <sch:pattern>
      <sch:title>$loc/strings/EC26</sch:title>

      <sch:rule context="//gmd:identificationInfo/gmd:citation/*/gmd:citedResponsibleParty/*/gmd:organisationName
                       |//*[@gco:isoType='gmd:MD_DataIdentification']/gmd:citation/*/gmd:citedResponsibleParty/*/gmd:organisationName
                       |//*[@gco:isoType='srv:SV_ServiceIdentification']/gmd:citation/*/gmd:citedResponsibleParty/*/gmd:organisationName">
        <sch:let name="government-titles" value="document(concat('file:///', $thesaurusDir, '/local/thesauri/theme/EC_Government_Titles.rdf'))"/>

        <sch:let name="organisationName" value="gco:CharacterString" />
        <sch:let name="isGovernmentOfCanada" value="starts-with(lower-case($organisationName), 'government of canada') or starts-with(lower-case($organisationName), 'gouvernement du canada')" />
        <sch:let name="titleName" value="lower-case(normalize-space(tokenize($organisationName, ';')[2]))" />

        <sch:assert test="not($isGovernmentOfCanada) or
                  ($isGovernmentOfCanada and (string($government-titles//rdf:Description[normalize-space(lower-case(ns2:prefLabel[@xml:lang='en'])) = $titleName]) or
                  string($government-titles//rdf:Description[normalize-space(lower-case(ns2:prefLabel[@xml:lang='fr'])) = $titleName]))
                  )">$loc/strings/EC26</sch:assert>


        <sch:let name="organisationNameOtherLang" value="gmd:PT_FreeText/gmd:textGroup/gmd:LocalisedCharacterString" />
        <sch:let name="isGovernmentOfCanadaOtherLang" value="starts-with(lower-case($organisationNameOtherLang), 'government of canada') or starts-with(lower-case($organisationNameOtherLang), 'gouvernement du canada')" />
        <sch:let name="titleNameOtherLang" value="lower-case(normalize-space(tokenize($organisationNameOtherLang, ';')[2]))" />

        <sch:assert test="not($isGovernmentOfCanadaOtherLang) or
                  ($isGovernmentOfCanadaOtherLang and (string($government-titles//rdf:Description[normalize-space(lower-case(ns2:prefLabel[@xml:lang='en'])) = $titleNameOtherLang]) or
                  string($government-titles//rdf:Description[normalize-space(lower-case(ns2:prefLabel[@xml:lang='fr'])) = $titleNameOtherLang]))
                  )">$loc/strings/EC26</sch:assert>
      </sch:rule>
    </sch:pattern>

   <sch:pattern>
      <sch:title>$loc/strings/ECCountry</sch:title>

       <sch:rule context="//gmd:identificationInfo/gmd:citation/*/gmd:citedResponsibleParty//gmd:country
                                                 |//*[@gco:isoType='gmd:MD_DataIdentification']/gmd:citation/*/gmd:citedResponsibleParty//gmd:country
                                                 |//*[@gco:isoType='srv:SV_ServiceIdentification']/gmd:citation/*/gmd:citedResponsibleParty//gmd:country">
        <sch:let name="country-values" value="document(concat('file:///', $thesaurusDir, '/local/thesauri/theme/EC_ISO_Countries.rdf'))"/>

        <sch:let name="countryName" value="lower-case(gco:CharacterString)" />
        <sch:let name="countryNameOtherLang" value="lower-case(gmd:PT_FreeText/gmd:textGroup/gmd:LocalisedCharacterString)" />

         <sch:assert test="(not($countryName) or
           ($countryName and (string($country-values//rdf:Description[lower-case(normalize-space(ns2:prefLabel[@xml:lang='en'])) = $countryName]) or
           string($country-values//rdf:Description[lower-case(normalize-space(ns2:prefLabel[@xml:lang='fr'])) = $countryName]))))

           and

           (not($countryNameOtherLang) or
                       ($countryNameOtherLang and (string($country-values//rdf:Description[lower-case(normalize-space(ns2:prefLabel[@xml:lang='en'])) = $countryNameOtherLang]) or
                       string($country-values//rdf:Description[lower-case(normalize-space(ns2:prefLabel[@xml:lang='fr'])) = $countryNameOtherLang]))
                       ))">$loc/strings/ECCountry</sch:assert>


      </sch:rule>
    </sch:pattern>

    <sch:pattern>
        <sch:title>$loc/strings/EC10</sch:title>

        <sch:rule context="//gmd:identificationInfo/*/gmd:topicCategory
                   |//*[@gco:isoType='gmd:MD_DataIdentification']/gmd:topicCategory
                   |//*[@gco:isoType='srv:SV_ServiceIdentification']/gmd:topicCategory">

                   <sch:let name="missing" value="not(string(gmd:MD_TopicCategoryCode))
                      " />

                   <sch:assert
                       test="not($missing)"
                       >$loc/strings/EC10</sch:assert>
        </sch:rule>
    </sch:pattern>

    <!-- Creation/revision dates -->
    <sch:pattern>
      <sch:rule context="//gmd:identificationInfo/gmd:citation/gmd:CI_Citation
                         |//*[@gco:isoType='gmd:MD_DataIdentification']/gmd:citation/gmd:CI_Citation
                         |//*[@gco:isoType='srv:SV_ServiceIdentification']/gmd:citation/gmd:CI_Citation">

        <sch:let name="missingPublication" value="count(gmd:date[gmd:CI_Date/gmd:dateType/gmd:CI_DateTypeCode/@codeListValue = 'RI_367']) = 0" />

        <sch:assert
          test="not($missingPublication)"
          >$loc/strings/EC24</sch:assert>

        <sch:let name="missingCreation" value="count(gmd:date[gmd:CI_Date/gmd:dateType/gmd:CI_DateTypeCode/@codeListValue = 'RI_366']) = 0" />

        <sch:assert
          test="not($missingCreation)"
          >$loc/strings/EC25</sch:assert>

      </sch:rule>
    </sch:pattern>

    <sch:pattern>
        <sch:title>$loc/strings/EC11</sch:title>

        <sch:rule context="//gmd:identificationInfo/gmd:MD_DataIdentification/gmd:spatialRepresentationType
                   |//*[@gco:isoType='gmd:MD_DataIdentification']/gmd:spatialRepresentationType
                   |//*[@gco:isoType='srv:SV_ServiceIdentification']/gmd:spatialRepresentationType">

                   <sch:let name="missing" value="not(string(gmd:MD_SpatialRepresentationTypeCode))
                      " />

                   <sch:assert
                       test="not($missing)"
                       >$loc/strings/EC11</sch:assert>
        </sch:rule>
    </sch:pattern>

      <sch:pattern>
        <sch:title>$loc/strings/EC12</sch:title>

        <sch:rule context="//gmd:identificationInfo/*/gmd:resourceConstraints/gmd:MD_LegalConstraints/gmd:accessConstraints
                   |//*[@gco:isoType='gmd:MD_DataIdentification']/gmd:resourceConstraints/gmd:MD_LegalConstraints/gmd:accessConstraints
                   |//*[@gco:isoType='srv:SV_ServiceIdentification']/gmd:resourceConstraints/gmd:MD_LegalConstraints/gmd:accessConstraints">

                   <sch:let name="missing" value="not(string(gmd:MD_RestrictionCode))
                      " />

            <sch:assert
                test="not($missing)"
                       >$loc/strings/EC12</sch:assert>
        </sch:rule>
    </sch:pattern>

   <sch:pattern>
          <sch:title>$loc/strings/EC13</sch:title>

          <sch:rule context="//gmd:identificationInfo/*/gmd:resourceConstraints/gmd:MD_LegalConstraints/gmd:useConstraints
                     |//*[@gco:isoType='gmd:MD_DataIdentification']/gmd:resourceConstraints/gmd:MD_LegalConstraints/gmd:useConstraints
                     |//*[@gco:isoType='srv:SV_ServiceIdentification']/gmd:resourceConstraints/gmd:MD_LegalConstraints/gmd:useConstraints">

                     <sch:let name="missing" value="not(string(gmd:MD_RestrictionCode))
                        " />

            <sch:assert
                test="not($missing)"
                         >$loc/strings/EC13</sch:assert>
        </sch:rule>
      </sch:pattern>

      <sch:pattern>
          <sch:title>$loc/strings/EC17</sch:title>

          <sch:rule context="//gmd:identificationInfo/*/gmd:resourceConstraints/gmd:MD_LegalConstraints/gmd:useLimitation
                     |//*[@gco:isoType='gmd:MD_DataIdentification']/gmd:resourceConstraints/gmd:MD_LegalConstraints/gmd:useLimitation
                     |//*[@gco:isoType='srv:SV_ServiceIdentification']/gmd:resourceConstraints/gmd:MD_LegalConstraints/gmd:useLimitation">

                    <sch:let name="missing" value="not(string(gco:CharacterString))
                        or (@gco:nilReason)" />

                    <sch:let name="missingOtherLang" value="not(string(gmd:PT_FreeText/gmd:textGroup/gmd:LocalisedCharacterString))" />

                    <sch:assert
                         test="not($missing and $missingOtherLang)"
                         >$loc/strings/EC17</sch:assert>

          </sch:rule>
    </sch:pattern>

    <!--<sch:pattern>
        <sch:title>$loc/strings/EC4</sch:title>

        <sch:rule context="//gmd:identificationInfo/*/gmd:descriptiveKeywords/gmd:MD_Keywords/gmd:type">

            <sch:let name="missing" value="not(string(gmd:MD_KeywordTypeCode/@codeListValue))" />

            <sch:assert
                test="not($missing)"
                >$loc/strings/EC4</sch:assert>

        </sch:rule>
    </sch:pattern>-->

    <sch:pattern>
        <sch:title>$loc/strings/EC8</sch:title>


        <sch:rule context="//gmd:identificationInfo/*/gmd:resourceConstraints/gmd:MD_LegalConstraints/gmd:otherConstraints">

          <sch:let name="filledFine" value="(
                (string(gco:CharacterString) or string(gmd:PT_FreeText/gmd:textGroup/gmd:LocalisedCharacterString))
                    and (../gmd:accessConstraints/gmd:MD_RestrictionCode/@codeListValue = 'RI_609'
                    or ../gmd:useConstraints/gmd:MD_RestrictionCode/@codeListValue = 'RI_609')) or

                    (not(string(gco:CharacterString)) and not(string(gmd:PT_FreeText/gmd:textGroup/gmd:LocalisedCharacterString))
                    and (../gmd:accessConstraints/gmd:MD_RestrictionCode/@codeListValue != 'RI_609'
                    and ../gmd:useConstraints/gmd:MD_RestrictionCode/@codeListValue != 'RI_609')
                    )" />
            <sch:assert
                test="$filledFine"
                >$loc/strings/EC8</sch:assert>

        </sch:rule>
    </sch:pattern>

    <sch:pattern>
            <sch:title>$loc/strings/EC9</sch:title>

            <sch:rule context="//gmd:distributionInfo/gmd:MD_Distribution/gmd:transferOptions/gmd:MD_DigitalTransferOptions/gmd:onLine/gmd:CI_OnlineResource/gmd:linkage/gmd:URL">

                <sch:let name="missing" value="not(string(.)) and not(string(../../../../gmd:onLine[@xlink:role!=../../../@xlink:role and @xlink:title=../../../@xlink:title]/gmd:CI_OnlineResource/gmd:linkage/gmd:URL))
                                               and (string(../../gmd:protocol/gco:CharacterString) or
                                                    string(../../gmd:name/gco:CharacterString) or
                                                    string(../../../../gmd:onLine[@xlink:role!=../../../@xlink:role and @xlink:title=../../../@xlink:title]/gmd:CI_OnlineResource/gmd:name/gco:CharacterString) or
                                                    string(../../../../gmd:onLine[@xlink:role!=../../../@xlink:role and @xlink:title=../../../@xlink:title]/gmd:CI_OnlineResource/gmd:description/gco:CharacterString) or
                                                    string(../../gmd:description/gco:CharacterString))"
                                                />

                <sch:assert
                    test="not($missing)"
                    >$loc/strings/EC9</sch:assert>

            </sch:rule>
        </sch:pattern>

        <sch:pattern>
            <sch:title>$loc/strings/EC14</sch:title>

            <sch:rule context="//gmd:distributionInfo/*/gmd:distributor/gmd:MD_Distributor/gmd:distributorContact/*/gmd:organisationName">

                <sch:let name="missing" value="not(string(gco:CharacterString))
                    or (@gco:nilReason)" />

                <sch:let name="missingOtherLang" value="not(string(gmd:PT_FreeText/gmd:textGroup/gmd:LocalisedCharacterString))" />

                <sch:assert
                    test="not($missing and $missingOtherLang)"
                    >$loc/strings/EC14</sch:assert>

            </sch:rule>
        </sch:pattern>

        <sch:pattern>
          <sch:title>$loc/strings/EC26</sch:title>

          <sch:rule context="//gmd:distributionInfo/*/gmd:distributor/gmd:MD_Distributor/gmd:distributorContact/*/gmd:organisationName">
            <sch:let name="government-titles" value="document(concat('file:///', $thesaurusDir, '/local/thesauri/theme/EC_Government_Titles.rdf'))"/>

            <sch:let name="organisationName" value="gco:CharacterString" />
            <sch:let name="isGovernmentOfCanada" value="starts-with(lower-case($organisationName), 'government of canada') or starts-with(lower-case($organisationName), 'gouvernement du canada')" />
            <sch:let name="titleName" value="lower-case(normalize-space(tokenize($organisationName, ';')[2]))" />

            <sch:assert test="not($isGovernmentOfCanada) or
                        ($isGovernmentOfCanada and (string($government-titles//rdf:Description[normalize-space(lower-case(ns2:prefLabel[@xml:lang='en'])) = $titleName]) or
                        string($government-titles//rdf:Description[normalize-space(lower-case(ns2:prefLabel[@xml:lang='fr'])) = $titleName]))
                        )">$loc/strings/EC26</sch:assert>


            <sch:let name="organisationNameOtherLang" value="gmd:PT_FreeText/gmd:textGroup/gmd:LocalisedCharacterString" />
            <sch:let name="isGovernmentOfCanadaOtherLang" value="starts-with(lower-case($organisationNameOtherLang), 'government of canada') or starts-with(lower-case($organisationNameOtherLang), 'gouvernement du canada')" />
            <sch:let name="titleNameOtherLang" value="lower-case(normalize-space(tokenize($organisationNameOtherLang, ';')[2]))" />

            <sch:assert test="not($isGovernmentOfCanadaOtherLang) or
                        ($isGovernmentOfCanadaOtherLang and (string($government-titles//rdf:Description[normalize-space(lower-case(ns2:prefLabel[@xml:lang='en'])) = $titleNameOtherLang]) or
                        string($government-titles//rdf:Description[normalize-space(lower-case(ns2:prefLabel[@xml:lang='fr'])) = $titleNameOtherLang]))
                        )">$loc/strings/EC26</sch:assert>
          </sch:rule>
        </sch:pattern>

      <sch:pattern>
          <sch:title>$loc/strings/ECCountry</sch:title>

           <sch:rule context="//gmd:distributionInfo/*/gmd:distributor/gmd:MD_Distributor/gmd:distributorContact//gmd:country">
            <sch:let name="country-values" value="document(concat('file:///', $thesaurusDir, '/local/thesauri/theme/EC_ISO_Countries.rdf'))"/>

            <sch:let name="countryName" value="lower-case(gco:CharacterString)" />
            <sch:let name="countryNameOtherLang" value="lower-case(gmd:PT_FreeText/gmd:textGroup/gmd:LocalisedCharacterString)" />

             <sch:assert test="(not($countryName) or
               ($countryName and (string($country-values//rdf:Description[lower-case(normalize-space(ns2:prefLabel[@xml:lang='en'])) = $countryName]) or
               string($country-values//rdf:Description[lower-case(normalize-space(ns2:prefLabel[@xml:lang='fr'])) = $countryName]))))

               and

               (not($countryNameOtherLang) or
                           ($countryNameOtherLang and (string($country-values//rdf:Description[lower-case(normalize-space(ns2:prefLabel[@xml:lang='en'])) = $countryNameOtherLang]) or
                           string($country-values//rdf:Description[lower-case(normalize-space(ns2:prefLabel[@xml:lang='fr'])) = $countryNameOtherLang]))
                           ))">$loc/strings/ECCountry</sch:assert>


          </sch:rule>
        </sch:pattern>

        <!--<sch:pattern>
          <sch:title>$loc/strings/EC18</sch:title>

          <sch:rule context="//gmd:referenceSystemInfo/gmd:MD_ReferenceSystem/gmd:referenceSystemIdentifier/gmd:RS_Identifier/gmd:codeSpace">

                     <sch:let name="missing" value="not(string(gco:CharacterString))
                        " />

                     <sch:assert
                         test="not($missing)"
                         >$loc/strings/EC18</sch:assert>
          </sch:rule>
        </sch:pattern>-->

        <sch:pattern>
          <sch:title>$loc/strings/EC19</sch:title>

          <sch:rule context="//gmd:metadataStandardName">

                     <sch:let name="correct" value="(gco:CharacterString = 'North American Profile of ISO 19115:2003 - Geographic information - Metadata' or
                      gco:CharacterString = 'Profil nord-américain de la norme ISO 19115:2003 - Information géographique - Métadonnées') and

                      (gmd:PT_FreeText/gmd:textGroup/gmd:LocalisedCharacterString = 'North American Profile of ISO 19115:2003 - Geographic information - Metadata' or
                       gmd:PT_FreeText/gmd:textGroup/gmd:LocalisedCharacterString = 'Profil nord-américain de la norme ISO 19115:2003 - Information géographique - Métadonnées')
                        " />

                     <sch:assert
                         test="$correct"
                         >$loc/strings/EC19</sch:assert>
          </sch:rule>
        </sch:pattern>

        <sch:pattern>
          <sch:title>$loc/strings/EC20</sch:title>

          <sch:rule context="/gmd:MD_Metadata/gmd:characterSet">

                    <sch:let name="correct" value="gmd:MD_CharacterSetCode = 'utf8; utf8' and gmd:MD_CharacterSetCode/@codeListValue = 'RI_458'
                        " />

                     <sch:assert
                         test="$correct"
                         >$loc/strings/EC20</sch:assert>
          </sch:rule>
        </sch:pattern>

  <sch:pattern>
    <sch:title>$loc/strings/EC21</sch:title>

    <sch:rule context="//gmd:distributionInfo/*/gmd:distributionFormat/*/gmd:name">

      <sch:let name="missing" value="not(string(gco:CharacterString))
                    or (@gco:nilReason)" />

      <sch:assert
        test="not($missing)"
        >$loc/strings/EC21</sch:assert>

    </sch:rule>
  </sch:pattern>

  <sch:pattern>
    <sch:title>$loc/strings/EC22</sch:title>

    <sch:rule context="//gmd:distributionInfo/*/gmd:distributionFormat/*/gmd:version">

      <sch:let name="missing" value="not(string(gco:CharacterString))
                    or (@gco:nilReason)" />

      <sch:assert
        test="not($missing)"
        >$loc/strings/EC22</sch:assert>

    </sch:rule>
  </sch:pattern>

  <sch:pattern>
    <sch:title>$loc/strings/EndPosition</sch:title>

    <sch:rule context="//gmd:identificationInfo/*/gmd:extent/*/gmd:temporalElement/*/gmd:extent/gml:TimePeriod/gml:endPosition
      |//*[@gco:isoType='gmd:MD_DataIdentification']/*/gmd:extent/*/gmd:temporalElement/*/gmd:extent/gml:TimePeriod/gml:endPosition
      |//*[@gco:isoType='srv:SV_ServiceIdentification']/*/gmd:extent/*/gmd:temporalElement/*/gmd:extent/gml:TimePeriod/gml:endPosition">

      <sch:let name="endPosition" value="." />
      <sch:let name="beginPosition" value="../gml:beginPosition" />

      <sch:assert test="geonet:compareDates($endPosition, $beginPosition) &gt;= 0">$loc/strings/EndPosition</sch:assert>
    </sch:rule>
  </sch:pattern>

  <!-- Xpaths include gml:TimePeriodTypeCHOICE_ELEMENT, added in editor -->
  <sch:pattern>
    <sch:title>$loc/strings/EndPosition</sch:title>

    <sch:rule context="//gmd:identificationInfo/*/gmd:extent/*/gmd:temporalElement/*/gmd:extent/gml:TimePeriod/*/gml:endPosition
      |//*[@gco:isoType='gmd:MD_DataIdentification']/*/gmd:extent/*/gmd:temporalElement/*/gmd:extent/gml:TimePeriod/*/gml:endPosition
      |//*[@gco:isoType='srv:SV_ServiceIdentification']/*/gmd:extent/*/gmd:temporalElement/*/gmd:extent/gml:TimePeriod/*/gml:endPosition">

      <sch:let name="endPosition" value="." />
      <sch:let name="beginPosition" value="../../*/gml:beginPosition" />

      <sch:assert test="geonet:compareDates($endPosition, $beginPosition) &gt;= 0">$loc/strings/EndPosition</sch:assert>
    </sch:rule>
  </sch:pattern>

  <sch:pattern>
    <sch:title>$loc/strings/EndPositionFormat</sch:title>

    <sch:rule context="//gmd:identificationInfo/*/gmd:extent/*/gmd:temporalElement/*/gmd:extent/gml:TimePeriod/gml:endPosition
      |//*[@gco:isoType='gmd:MD_DataIdentification']/*/gmd:extent/*/gmd:temporalElement/*/gmd:extent/gml:TimePeriod/gml:endPosition
      |//*[@gco:isoType='srv:SV_ServiceIdentification']/*/gmd:extent/*/gmd:temporalElement/*/gmd:extent/gml:TimePeriod/gml:endPosition">

      <sch:let name="endPosition" value="." />

      <sch:assert test="geonet:verifyDateFormat($endPosition) &gt; 0">$loc/strings/EndPositionFormat</sch:assert>
    </sch:rule>
  </sch:pattern>

  <!-- Xpaths include gml:TimePeriodTypeCHOICE_ELEMENT, added in editor -->
  <sch:pattern>
    <sch:title>$loc/strings/EndPositionFormat</sch:title>

    <sch:rule context="//gmd:identificationInfo/*/gmd:extent/*/gmd:temporalElement/*/gmd:extent/gml:TimePeriod/*/gml:endPosition
      |//*[@gco:isoType='gmd:MD_DataIdentification']/*/gmd:extent/*/gmd:temporalElement/*/gmd:extent/gml:TimePeriod/*/gml:endPosition
      |//*[@gco:isoType='srv:SV_ServiceIdentification']/*/gmd:extent/*/gmd:temporalElement/*/gmd:extent/gml:TimePeriod/*/gml:endPosition">

      <sch:let name="endPosition" value="." />

      <sch:assert test="geonet:verifyDateFormat($endPosition) &gt; 0">$loc/strings/EndPositionFormat</sch:assert>
    </sch:rule>
  </sch:pattern>

  <sch:pattern>
    <sch:title>$loc/strings/BeginPositionFormat</sch:title>

    <sch:rule context="//gmd:identificationInfo/*/gmd:extent/*/gmd:temporalElement/*/gmd:extent/gml:TimePeriod/gml:beginPosition
      |//*[@gco:isoType='gmd:MD_DataIdentification']/*/gmd:extent/*/gmd:temporalElement/*/gmd:extent/gml:TimePeriod/gml:beginPosition
      |//*[@gco:isoType='srv:SV_ServiceIdentification']/*/gmd:extent/*/gmd:temporalElement/*/gmd:extent/gml:TimePeriod/gml:beginPosition">

      <sch:let name="beginPosition" value="." />

      <sch:assert test="geonet:verifyDateFormat($beginPosition) &gt; 0">$loc/strings/BeginPositionFormat</sch:assert>
    </sch:rule>
  </sch:pattern>

  <!-- Xpaths include gml:TimePeriodTypeCHOICE_ELEMENT, added in editor -->
  <sch:pattern>
    <sch:title>$loc/strings/BeginPositionFormat</sch:title>

    <sch:rule context="//gmd:identificationInfo/*/gmd:extent/*/gmd:temporalElement/*/gmd:extent/gml:TimePeriod/*/gml:beginPosition
      |//*[@gco:isoType='gmd:MD_DataIdentification']/*/gmd:extent/*/gmd:temporalElement/*/gmd:extent/gml:TimePeriod/*/gml:beginPosition
      |//*[@gco:isoType='srv:SV_ServiceIdentification']/*/gmd:extent/*/gmd:temporalElement/*/gmd:extent/gml:TimePeriod/*/gml:beginPosition">

      <sch:let name="beginPosition" value="." />

      <sch:assert test="geonet:verifyDateFormat($beginPosition) &gt; 0">$loc/strings/BeginPositionFormat</sch:assert>
    </sch:rule>
  </sch:pattern>

  <!--<sch:pattern>
    <sch:title>$loc/strings/21</sch:title>


    <sch:rule context="//gmd:identificationInfo/*/gmd:extent/*/gmd:temporalElement/*/gmd:extent/gml:TimePeriod/*/gml:beginPosition
                         |//*[@gco:isoType='gmd:MD_DataIdentification']/*/gmd:extent/*/gmd:temporalElement/*/gmd:extent/gml:TimePeriod/*/gml:beginPosition
                         |//*[@gco:isoType='srv:SV_ServiceIdentification']/*/gmd:extent/*/gmd:temporalElement/*/gmd:extent/gml:TimePeriod/*/gml:beginPosition">


      <sch:let name="correct" value="(
                      not(string(.))
                      or (matches(., '\d{4}'))
                      or (matches(., '\d{4}\-\d{2}\-\d{2}'))
                      or (matches(., '\d{4}\-\d{2}\-\d{2}'))

                      )" />


      <sch:assert
        test="$correct"
        >$loc/strings/EC21</sch:assert>
    </sch:rule>
  </sch:pattern>

  <sch:pattern>
    <sch:title>$loc/strings/22</sch:title>


    <sch:rule context="//gmd:identificationInfo/*/gmd:extent/*/gmd:temporalElement/*/gmd:extent/gml:TimePeriod/*/gml:endPosition
                         |//*[@gco:isoType='gmd:MD_DataIdentification']/*/gmd:extent/*/gmd:temporalElement/*/gmd:extent/gml:TimePeriod/*/gml:endPosition
                         |//*[@gco:isoType='srv:SV_ServiceIdentification']/*/gmd:extent/*/gmd:temporalElement/*/gmd:extent/gml:TimePeriod/*/gml:endPosition">


      <sch:let name="correct" value="(
                      not(string(.))
                      or (matches(., '\d{4}'))
                      or (matches(., '\d{4}\-\d{2}\-\d{2}'))
                      or (matches(., '\d{4}\-\d{2}\-\d{2}'))

                      )" />



      <sch:assert
        test="$correct"
        >$loc/strings/EC22</sch:assert>

    </sch:rule>
  </sch:pattern>-->

  <!--<sch:pattern>
    <sch:title>$loc/strings/EC21</sch:title>


    <sch:rule context="//gmd:identificationInfo/*/gmd:extent/*/gmd:temporalElement/*/gmd:extent/gml:TimePeriod
                   |//*[@gco:isoType='gmd:MD_DataIdentification']/*/gmd:extent/*/gmd:temporalElement/*/gmd:extent/gml:TimePeriod
                   |//*[@gco:isoType='srv:SV_ServiceIdentification']/*/gmd:extent/*/gmd:temporalElement/*/gmd:extent/gml:TimePeriod">

      <sch:let name="ok_values" value="(not(string(gml:beginPosition) and not(string(gml:beginPosition))
                or (gml:beginPosition < gml:endPosition)" />


      <sch:assert
        test="$ok_values"
        >$loc/strings/EC21</sch:assert>

    </sch:rule>
  </sch:pattern>-->

  <sch:pattern>
    <sch:title>$loc/strings/EC23</sch:title>

    <sch:rule context="//gmd:distributionInfo/gmd:MD_Distribution/gmd:transferOptions/gmd:MD_DigitalTransferOptions/gmd:onLine">

      <sch:let name="missingLanguageForMapService" value="not(string(@xlink:role)) and (lower-case(gmd:CI_OnlineResource/gmd:protocol/gco:CharacterString) = 'ogc:wms' or lower-case(gmd:CI_OnlineResource/gmd:protocol/gco:CharacterString) = 'esri rest: map service')" />

      <sch:assert
        test="not($missingLanguageForMapService)"
        >$loc/strings/EC23</sch:assert>

    </sch:rule>
  </sch:pattern>

  <sch:pattern>
    <sch:title>$loc/strings/MapResourcesREST</sch:title>

    <!-- Online resource -->
    <sch:rule context="//gmd:distributionInfo/gmd:MD_Distribution">
      <sch:let name="smallcase" value="'abcdefghijklmnopqrstuvwxyz'" />
      <sch:let name="uppercase" value="'ABCDEFGHIJKLMNOPQRSTUVWXYZ'" />

      <sch:let name="mapRESTCount" value="count(gmd:transferOptions/gmd:MD_DigitalTransferOptions/gmd:onLine[@xlink:role='urn:xml:lang:eng-CAN' and translate(gmd:CI_OnlineResource/gmd:protocol/gco:CharacterString, $uppercase, $smallcase) = 'esri rest: map service']) +
                count(gmd:transferOptions/gmd:MD_DigitalTransferOptions/gmd:onLine[@xlink:role='urn:xml:lang:fra-CAN' and translate(gmd:CI_OnlineResource/gmd:protocol/gco:CharacterString, $uppercase, $smallcase) = 'esri rest: map service'])" />

        <sch:assert test="$mapRESTCount &lt;= 2">$loc/strings/MapResourcesRESTNumber</sch:assert>
        <sch:assert test="$mapRESTCount = 0 or $mapRESTCount = 2 or $mapRESTCount &gt; 2">$loc/strings/MapResourcesREST</sch:assert>
    </sch:rule>
  </sch:pattern>

  <sch:pattern>
    <sch:title>$loc/strings/MapResourcesWMS</sch:title>

    <!-- Online resource -->
    <sch:rule context="//gmd:distributionInfo/gmd:MD_Distribution">
      <sch:let name="smallcase" value="'abcdefghijklmnopqrstuvwxyz'" />
      <sch:let name="uppercase" value="'ABCDEFGHIJKLMNOPQRSTUVWXYZ'" />

      <sch:let name="mapWMSCount" value="count(gmd:transferOptions/gmd:MD_DigitalTransferOptions/gmd:onLine[@xlink:role='urn:xml:lang:eng-CAN' and translate(gmd:CI_OnlineResource/gmd:protocol/gco:CharacterString, $uppercase, $smallcase) = 'ogc:wms']) +
                count(gmd:transferOptions/gmd:MD_DigitalTransferOptions/gmd:onLine[@xlink:role='urn:xml:lang:fra-CAN' and translate(gmd:CI_OnlineResource/gmd:protocol/gco:CharacterString, $uppercase, $smallcase) = 'ogc:wms'])" />

        <sch:assert test="$mapWMSCount &lt;= 2">$loc/strings/MapResourcesWMSNumber</sch:assert>
        <sch:assert test="$mapWMSCount = 0 or $mapWMSCount = 2 or $mapWMSCount &gt; 2">$loc/strings/MapResourcesWMS</sch:assert>
    </sch:rule>
  </sch:pattern>

  <sch:pattern>
    <sch:title>$loc/strings/ResourceDescription</sch:title>

    <!-- Online resource description -->
    <sch:rule context="//gmd:distributionInfo/gmd:MD_Distribution/gmd:transferOptions/gmd:MD_DigitalTransferOptions/gmd:onLine">
      <sch:let name="smallcase" value="'abcdefghijklmnopqrstuvwxyz'" />
      <sch:let name="uppercase" value="'ABCDEFGHIJKLMNOPQRSTUVWXYZ'" />
      <sch:let name="formats-list" value="document(concat('file:///', $thesaurusDir, '/local/thesauri/theme/EC_Resource_Formats.rdf'))"/>

      <sch:let name="description" value="gmd:CI_OnlineResource/gmd:description/gco:CharacterString" />
      <sch:let name="contentType" value="subsequence(tokenize($description, ';'), 1, 1)" />
      <sch:let name="format" value="subsequence(tokenize($description, ';'), 2, 1)" />
      <sch:let name="language" value="subsequence(tokenize($description, ';'), 3, 1)" />
      <sch:let name="language_present" value="geonet:values-in($language,
            ('eng', 'fra', 'spa', 'zxx'))"/>

      <sch:let name="descriptionTranslated" value="gmd:CI_OnlineResource/gmd:description/gmd:PT_FreeText/gmd:textGroup/gmd:LocalisedCharacterString" />
      <sch:let name="contentTypeTranslated" value="subsequence(tokenize($descriptionTranslated, ';'), 1, 1)" />
      <sch:let name="languageTraslated" value="subsequence(tokenize($descriptionTranslated, ';'), 3, 1)" />

      <sch:let name="languageTranslated_present" value="geonet:values-in($language,
            ('eng', 'fra', 'spa', 'zxx'))"/>

      <sch:assert test="($contentType = 'Web Service' or $contentType = 'Service Web' or
            $contentType = 'Dataset' or $contentType = 'Données' or
            $contentType = 'API' or $contentType = 'Application' or
            $contentType='Supporting Document' or $contentType = 'Document de soutien') and
            ($contentTypeTranslated = 'Web Service' or $contentTypeTranslated = 'Service Web' or
            $contentTypeTranslated = 'Dataset' or $contentTypeTranslated = 'Données' or
            $contentTypeTranslated = 'API' or $contentTypeTranslated = 'Application' or
            $contentTypeTranslated='Supporting Document' or $contentTypeTranslated = 'Document de soutien')">$loc/strings/ResourceDescriptionContentType</sch:assert>

      <sch:let name="formatTranslated" value="subsequence(tokenize($descriptionTranslated, ';'), 2, 1)" />
      <sch:let name="resourceFormatsList" value="geonet:resourceFormatsList($thesaurusDir)" />
      <sch:let name="locMsg" value="concat($loc/strings/ResourceDescriptionFormat, $resourceFormatsList)" />

      <sch:assert test="string($formats-list//rdf:Description[@rdf:about = concat('http://geonetwork-opensource.org/EC/resourceformat#', $format)]) and
                               string($formats-list//rdf:Description[@rdf:about = concat('http://geonetwork-opensource.org/EC/resourceformat#',$formatTranslated)])">$locMsg</sch:assert>

      <sch:assert test="normalize-space($language) != '' and normalize-space($languageTraslated) != ''">$loc/strings/ResourceDescriptionLanguage</sch:assert>

      <sch:assert test="$language_present and $languageTranslated_present">$loc/strings/ResourceDescriptionLanguage</sch:assert>
    </sch:rule>
  </sch:pattern>

    <!-- Thesaurus info -->
      <sch:pattern>
          <sch:rule context="//gmd:descriptiveKeywords">

              <sch:let name="thesaurusNamePresent" value="count(gmd:MD_Keywords/gmd:thesaurusName/gmd:CI_Citation) > 0" />


              <sch:let name="missingTitle" value="not(string(gmd:MD_Keywords/gmd:thesaurusName/gmd:CI_Citation/gmd:title/gco:CharacterString))
                  or (@gco:nilReason)" />

              <sch:let name="missingTitleOtherLang" value="not(string(gmd:MD_Keywords/gmd:thesaurusName/gmd:CI_Citation/gmd:title/gmd:PT_FreeText/gmd:textGroup/gmd:LocalisedCharacterString))" />

              <sch:assert
                  test="not($thesaurusNamePresent) or ($thesaurusNamePresent and not($missingTitle) and not($missingTitleOtherLang))"
                  >$loc/strings/ECThesaurusTitle</sch:assert>


              <sch:let name="missingPublication" value="count(gmd:MD_Keywords/gmd:thesaurusName/gmd:CI_Citation/gmd:date[gmd:CI_Date/gmd:dateType/gmd:CI_DateTypeCode/@codeListValue = 'RI_367']) = 0" />

              <sch:assert
                  test="not($thesaurusNamePresent) or ($thesaurusNamePresent and not($missingPublication))"
                  >$loc/strings/ECThesaurusPubDate</sch:assert>

              <sch:let name="missingCreation" value="count(gmd:MD_Keywords/gmd:thesaurusName/gmd:CI_Citation/gmd:date[gmd:CI_Date/gmd:dateType/gmd:CI_DateTypeCode/@codeListValue = 'RI_366']) = 0" />

              <sch:assert
                  test="not($thesaurusNamePresent) or ($thesaurusNamePresent and not($missingCreation))"
                  >$loc/strings/ECThesaurusCreDate</sch:assert>


              <sch:let name="missingRole" value="not(string(gmd:MD_Keywords/gmd:thesaurusName/gmd:CI_Citation/gmd:citedResponsibleParty/gmd:CI_ResponsibleParty/gmd:role/gmd:CI_RoleCode/@codeListValue))" />

              <sch:assert
                  test="not($thesaurusNamePresent) or ($thesaurusNamePresent and not($missingRole))"
                  >$loc/strings/ECThesaurusRole</sch:assert>

              <sch:let name="missingOrganisation" value="not(string(gmd:MD_Keywords/gmd:thesaurusName/gmd:CI_Citation/gmd:citedResponsibleParty/gmd:CI_ResponsibleParty/gmd:organisationName/gco:CharacterString))
                  or (@gco:nilReason)" />

              <sch:let name="missingOrganisationOtherLang" value="not(string(gmd:MD_Keywords/gmd:thesaurusName/gmd:CI_Citation/gmd:citedResponsibleParty/gmd:CI_ResponsibleParty/gmd:organisationName/gmd:PT_FreeText/gmd:textGroup/gmd:LocalisedCharacterString))" />

              <sch:assert
                  test="not($thesaurusNamePresent) or ($thesaurusNamePresent and not($missingOrganisation) and not($missingOrganisationOtherLang))"
                  >$loc/strings/ECThesaurusOrg</sch:assert>

              <sch:let name="emailPresent" value="count(gmd:MD_Keywords/gmd:thesaurusName/gmd:CI_Citation/gmd:citedResponsibleParty/gmd:CI_ResponsibleParty/gmd:contactInfo/gmd:CI_Contact/gmd:address/gmd:CI_Address/gmd:electronicMailAddress) > 0" />

              <sch:let name="missingEmail" value="not(string(gmd:MD_Keywords/gmd:thesaurusName/gmd:CI_Citation/gmd:citedResponsibleParty/gmd:CI_ResponsibleParty/gmd:contactInfo/gmd:CI_Contact/gmd:address/gmd:CI_Address/gmd:electronicMailAddress/gco:CharacterString))
                  or (@gco:nilReason)" />

              <sch:let name="missingEmailOtherLang" value="not(string(gmd:MD_Keywords/gmd:thesaurusName/gmd:CI_Citation/gmd:citedResponsibleParty/gmd:CI_ResponsibleParty/gmd:contactInfo/gmd:CI_Contact/gmd:address/gmd:CI_Address/gmd:electronicMailAddress/gmd:PT_FreeText/gmd:textGroup/gmd:LocalisedCharacterString))" />

              <sch:assert
                  test="not($thesaurusNamePresent) or ($thesaurusNamePresent and (not($emailPresent) or ($emailPresent and not($missingEmail) and not($missingEmailOtherLang))))"
                  >$loc/strings/ECThesaurusEmail</sch:assert>
          </sch:rule>
      </sch:pattern>


     <sch:pattern>
        <sch:title>$loc/strings/OpenLicense</sch:title>

        <!-- Use Limitation -->
        <sch:rule context="//gmd:identificationInfo/gmd:MD_DataIdentification
                |//*[@gco:isoType='gmd:MD_DataIdentification']
                |//*[@gco:isoType='srv:SV_ServiceIdentification']">

          <sch:let name="openLicense" value="count(gmd:resourceConstraints/gmd:MD_LegalConstraints/gmd:useLimitation[
                    (normalize-space(gco:CharacterString) = 'Open Government Licence - Canada (http://open.canada.ca/en/open-government-licence-canada)' and
                    normalize-space(gmd:PT_FreeText/gmd:textGroup/gmd:LocalisedCharacterString[@locale='#fra']) = 'Licence du gouvernement ouvert - Canada (http://ouvert.canada.ca/fr/licence-du-gouvernement-ouvert-canada)') or
                    (normalize-space(gco:CharacterString) = 'Licence du gouvernement ouvert - Canada (http://ouvert.canada.ca/fr/licence-du-gouvernement-ouvert-canada)' and
                    normalize-space(gmd:PT_FreeText/gmd:textGroup/gmd:LocalisedCharacterString[@locale='#eng'])  = 'Open Government Licence - Canada (http://open.canada.ca/en/open-government-licence-canada)')])"/>

          <sch:assert
            test="$openLicense > 0"
            >$loc/strings/OpenLicense</sch:assert>

        </sch:rule>
      </sch:pattern>

    <sch:pattern>
      <sch:title>$loc/strings/EC35</sch:title>

      <sch:rule context="//gmd:identificationInfo/gmd:MD_DataIdentification
            |//*[@gco:isoType='gmd:MD_DataIdentification']
            |//*[@gco:isoType='srv:SV_ServiceIdentification']">

      <sch:let name="missing" value="not(gmd:spatialRepresentationType)
                          " />

          <sch:assert
            test="not($missing)"
            >$loc/strings/EC35</sch:assert>
        </sch:rule>
    </sch:pattern>

    <!-- Mandatory, if spatialRepresentionType in Data Identification is "vector," "grid" or "tin”. -->
    <sch:pattern>
        <sch:title>$loc/strings/ReferenceSystemInfo</sch:title>

        <sch:rule context="/gmd:MD_Metadata">
          <sch:let name="spatialRepresentationType" value="concat(//gmd:identificationInfo/*/gmd:spatialRepresentationType/gmd:MD_SpatialRepresentationTypeCode/@codeListValue, '')" />

          <sch:let name="missing" value="not(gmd:referenceSystemInfo)
                " />

            <sch:assert
                test="(($spatialRepresentationType = 'RI_635' or $spatialRepresentationType = 'RI_636' or $spatialRepresentationType = 'RI_638') and not($missing)) or
                ($spatialRepresentationType != 'RI_635' and $spatialRepresentationType != 'RI_636' and $spatialRepresentationType != 'RI_638')"
                >$loc/strings/ReferenceSystemInfo</sch:assert>
        </sch:rule>
    </sch:pattern>

    <sch:pattern>
        <sch:title>$loc/strings/ReferenceSystemInfoCode</sch:title>

        <sch:rule context="//gmd:referenceSystemInfo/gmd:MD_ReferenceSystem/gmd:referenceSystemIdentifier/gmd:RS_Identifier/gmd:code">
            <sch:let name="missing" value="not(string(gco:CharacterString))
                " />

            <sch:assert
                test="not($missing)"
                >$loc/strings/ReferenceSystemInfoCode</sch:assert>
        </sch:rule>
    </sch:pattern>
</sch:schema>
