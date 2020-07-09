<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:dc="http://purl.org/dc/elements/1.1/" xmlns:sru_dc="info:srw/schema/1/dc-schema"
    xmlns:oai_dc="http://www.openarchives.org/OAI/2.0/oai_dc/"
    xmlns:xlink="http://www.w3.org/1999/xlink" xmlns="http://www.loc.gov/mods/v3"
    xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" exclude-result-prefixes="sru_dc oai_dc dc"
    version="2.0">

    <xsl:strip-space elements="*"/>
    <xsl:output indent="yes"/>

    <xsl:template match="DISS_submission">
        <mods xmlns="http://www.loc.gov/mods/v3"
            xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
            xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:xlink="http://www.w3.org/1999/xlink"
            xmlns:mods="http://www.loc.gov/mods/v3" version="3.7"
            xsi:schemaLocation="http://www.loc.gov/mods/v3 http://www.loc.gov/standards/mods/v3/mods-3-7.xsd">
            <xsl:apply-templates/>
            <physicalDescription>
                <digitalOrigin>born digital</digitalOrigin>
                <internetMediaType>application/pdf</internetMediaType>
            </physicalDescription>
            <accessCondition type="useAndReproduction" displayLabel="rightsstatements.org">In
                Copyright</accessCondition>
            <accessCondition type="useAndReproduction" displayLabel="rightsstatements.orgURI"
                >http://rightsstatements.org/page/InC/1.0/</accessCondition>
            <accessCondition type="restrictionOnAccess">Restricted Access</accessCondition>
            <xsl:if test="@embargo_code != '0'">
                <note type="embargo">
                    <xsl:text>Embargo Until: </xsl:text>
                    <xsl:value-of select="DISS_restriction/DISS_sales_restriction/@remove"/>
                </note>
            </xsl:if>
        </mods>
    </xsl:template>

    <xsl:template match="DISS_title">
        <titleInfo>
            <title>
                <xsl:value-of select="."/>
            </title>
        </titleInfo>
    </xsl:template>

    <xsl:template match="DISS_author[@type = 'primary']">
        <name>
            <role>
                <roleTerm type="text" authority="marcrelator"
                    authorityURI="http://id.loc.gov/vocabulary/relators"
                    valueURI="http://id.loc.gov/vocabulary/relators/cre">creator</roleTerm>
            </role>
            <namePart>
                <xsl:value-of select="DISS_name/DISS_surname"/>
                <xsl:text>, </xsl:text>
                <xsl:value-of select="DISS_name/DISS_fname"/>
                <xsl:if test="DISS_name/DISS_middle != ''">
                    <xsl:text> </xsl:text>
                </xsl:if>
                <xsl:value-of select="DISS_name/DISS_middle"/>
                <xsl:if test="DISS_name/DISS_suffix != ''">
                    <xsl:text>, </xsl:text>
                </xsl:if>
                <xsl:value-of select="DISS_name/DISS_suffix"/>
            </namePart>
        </name>
    </xsl:template>


    <xsl:template match="DISS_advisor">
        <name>
            <role>
                <roleTerm type="text" authority="marcrelator"
                    authorityURI="http://id.loc.gov/vocabulary/relators"
                    valueURI="http://id.loc.gov/vocabulary/relators/cre">advisor</roleTerm>
            </role>
            <namePart>
                <xsl:value-of select="DISS_name/DISS_surname"/>
                <xsl:text>, </xsl:text>
                <xsl:value-of select="DISS_name/DISS_fname"/>
                <xsl:if test="DISS_name/DISS_middle != ''">
                    <xsl:text> </xsl:text>
                </xsl:if>
                <xsl:value-of select="DISS_name/DISS_middle"/>
                <xsl:if test="DISS_name/DISS_suffix != ''">
                    <xsl:text>, </xsl:text>
                </xsl:if>
                <xsl:value-of select="DISS_name/DISS_suffix"/>
            </namePart>
        </name>
    </xsl:template>

    <xsl:template match="DISS_abstract">
        <abstract>
            <xsl:for-each select="DISS_para">
                <xsl:value-of select="."/>
            </xsl:for-each>
        </abstract>
    </xsl:template>

    <xsl:template match="DISS_comp_date">
        <originInfo>
            <dateCreated keyDate="yes">
                <xsl:value-of select="."/>
            </dateCreated>
        </originInfo>
        <note displayLabel="Degree Awarded">
            <xsl:text>Spring </xsl:text>
            <xsl:value-of select="."/>
        </note>
    </xsl:template>

    <xsl:template match="DISS_language">
        <language>
            <languageTerm type="code" authority="rfc3066">
                <xsl:value-of select="."/>
            </languageTerm>
        </language>
    </xsl:template>

    <xsl:template match="DISS_inst_name">
        <name type="corporate">
            <affiliation>
                <xsl:value-of select="."/>
            </affiliation>
        </name>
    </xsl:template>

    <xsl:template match="DISS_cat_desc">
        <subject>
            <topic>
                <xsl:value-of select="."/>
            </topic>
        </subject>
    </xsl:template>

    <xsl:template match="DISS_keyword">
        <xsl:for-each select="tokenize(text(), ',')">
            <subject>
                <topic>
                    <xsl:value-of select="normalize-space(.)"/>
                </topic>
            </subject>
        </xsl:for-each>
    </xsl:template>

    <!-- need to normalize deparments so there's a long if/case statement below -->

    <xsl:template match="DISS_degree">
        <xsl:if test="text() = 'Ph.D.'">
            <typeOfResource authority="aat" valueURI="http://vocab.getty.edu/page/aat/300028029"
                >Dissertation</typeOfResource>
        </xsl:if>
        <xsl:if test="text() != 'Ph.D.'">
            <typeOfResource authority="aat" valueURI="http://vocab.getty.edu/page/aat/300028029"
                >Thesis</typeOfResource>
        </xsl:if>
    </xsl:template>
    <xsl:template match="DISS_inst_contact">
        <xsl:if test="text() = 'Electrical and Computer Engineering'">
            <name type="corporate">
                <namePart>ECE / Electrical and Computer Engineering</namePart>
            </name>
        </xsl:if>

        <xsl:if test="text() = 'Architecture'">
            <name type="corporate">
                <namePart>ARCH / Architecture</namePart>
            </name>
        </xsl:if>

        <xsl:if test="text() = 'Mechanical, Materials and Aerospace Engineering'">
            <name type="corporate">
                <namePart>MMAE / Mechanical, Materials, and Aerospace Engineering</namePart>
            </name>
        </xsl:if>

        <xsl:if test="text() = 'Biology'">
            <name type="corporate">
                <namePart>BIOL / Biology</namePart>
            </name>
        </xsl:if>

        <xsl:if test="text() = 'Biomedical Engineering'">
            <name type="corporate">
                <namePart>BME / Biomedical Engineering</namePart>
            </name>
        </xsl:if>

        <xsl:if test="text() = 'Chemical and Biological Engineering'">
            <name type="corporate">
                <namePart>ChBE / Chemical and Biological Engineering</namePart>
            </name>
        </xsl:if>

        <xsl:if test="text() = 'Civil, Architectural, and Environmental Engineering'">
            <name type="corporate">
                <namePart>CAEE / Civil, Architectural, and Environmental Engineering</namePart>
            </name>
        </xsl:if>

        <xsl:if test="text() = 'Chemistry'">
            <name type="corporate">
                <namePart>CHEM / Chemistry</namePart>
            </name>
        </xsl:if>

        <xsl:if test="text() = 'Computer Science'">
            <name type="corporate">
                <namePart>CS / Computer Science</namePart>
            </name>
        </xsl:if>

        <xsl:if test="text() = 'Institute for Food Safety and Health'">
            <name type="corporate">
                <namePart>IFSH / Institute for Food Safety and Health</namePart>
            </name>
        </xsl:if>

        <xsl:if test="text() = 'Humanities'">
            <name type="corporate">
                <namePart>HUM / Humanities</namePart>
            </name>
        </xsl:if>

        <xsl:if test="text() = 'Institute of Design'">
            <name type="corporate">
                <namePart>ID / Institute of Design</namePart>
            </name>
        </xsl:if>

        <xsl:if test="text() = 'Applied Mathematics'">
            <name type="corporate">
                <namePart>MATH / Applied Mathematics</namePart>
            </name>
        </xsl:if>

        <xsl:if test="text() = 'Physics'">
            <name type="corporate">
                <namePart>PHYS / Physics</namePart>
            </name>
        </xsl:if>

        <xsl:if test="text() = 'Psychology'">
            <name type="corporate">
                <namePart>PSYC / Psychology</namePart>
            </name>
        </xsl:if>

        <xsl:if test="contains(text(), 'Science Education')">
            <name type="corporate">
                <namePart>MSeD / Mathematics and Science Education</namePart>
            </name>
        </xsl:if>

        <xsl:if test="text() = 'School of Applied Technology'">
            <name type="corporate">
                <namePart>SAT / School of Applied Technology</namePart>
            </name>
        </xsl:if>

        <xsl:if test="text() = 'Stuart School of Business'">
            <name type="corporate">
                <namePart>SSB / Stuart School of Business</namePart>
            </name>
        </xsl:if>

        <xsl:if test="text() = 'Social Sciences'">
            <name type="corporate">
                <namePart>SSCI / Social Sciences</namePart>
            </name>
        </xsl:if>

    </xsl:template>

    <xsl:template
        match="DISS_processing_code | DISS_binary | DISS_repository | DISS_contact | DISS_inst_code | DISS_accept_date | DISS_cat_code | DISS_cmte_member"> </xsl:template>

</xsl:stylesheet>
