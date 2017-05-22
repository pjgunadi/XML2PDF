<?xml version="1.0"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:fo="http://www.w3.org/1999/XSL/Format" xmlns:max="http://www.ibm.com/maximo" exclude-result-prefixes="max">
  <xsl:output method="xml" encoding="UTF-8" indent="yes"/>
  <xsl:strip-space elements="*"/>
  <xsl:template match="max:QueryMXOSINCIDENTResponse">
          <xsl:apply-templates select="max:MXOSINCIDENTSet"/>
  </xsl:template>
  <xsl:template match="max:MXOSINCIDENTSet">
    <fo:root font-family="Tahoma" font-size="10pt">
      <fo:layout-master-set>
        <fo:simple-page-master master-name="A4p" page-height="297mm" page-width="210mm" margin-top="10mm" margin-bottom="20mm" margin-left="25mm" margin-right="25mm">
          <fo:region-body margin-top="30mm"/>
          <fo:region-before extent="30mm"/>
          <fo:region-after extent="15mm"/>
        </fo:simple-page-master>
      </fo:layout-master-set>
      <fo:page-sequence master-reference="A4p">
        <!-- Header -->
        <fo:static-content flow-name="xsl-region-before">
          <fo:block text-align="right" padding="1.5mm">
            <fo:external-graphic src="file:images/logo.png"/>
          </fo:block>
        </fo:static-content>

        <!-- Footer -->
        <fo:static-content flow-name="xsl-region-after">
          <fo:block padding="1.5mm">
            Footer
          </fo:block>
        </fo:static-content>

        <!-- Body -->
        <fo:flow flow-name="xsl-region-body">
    <fo:block page-break-after="always">
      <fo:block padding="1.5mm">
        <fo:table table-layout="fixed" width="100%" border-collapse="separate">
          <fo:table-column column-width="50%"/>
          <fo:table-column column-width="50%"/>
          <fo:table-body>
            <fo:table-row>
              <fo:table-cell ><fo:block><xsl:text>123/456/789</xsl:text></fo:block></fo:table-cell>
              <fo:table-cell ><fo:block text-align="right">
                <xsl:variable name="cdt" select="max:INCIDENT/max:ACTUALFINISH"/>
                <xsl:if test="$cdt != ''">
                  <xsl:value-of select="concat(substring($cdt,9,2),'-',substring($cdt,6,2),'-',substring($cdt,1,4))"/>
                </xsl:if>
              </fo:block></fo:table-cell>
            </fo:table-row>
          </fo:table-body>
        </fo:table>
      </fo:block>
      <fo:block padding="1.5mm">
        <fo:inline>Dear, </fo:inline>
        <fo:inline><xsl:value-of select="max:INCIDENT/max:AFFECTEDPERSON"/></fo:inline>
      </fo:block>
      <fo:block padding="1.5mm">
        <fo:inline>Ticket ID: </fo:inline>
        <fo:inline><xsl:value-of select="max:INCIDENT/max:TICKETID"/></fo:inline>
      </fo:block>
      <fo:block padding="3mm"/>
      <fo:block padding="1.5mm">
        <fo:inline>Affected Circuits:</fo:inline>
      </fo:block>
      <xsl:if test="max:INCIDENT/max:MULTIASSETLOCCI/max:CINUM">
        <!-- table start -->
        <fo:block padding="1.5mm">
          <fo:table table-layout="fixed" width="100%" border-collapse="separate">
            <fo:table-column column-width="50mm"/>
            <fo:table-column column-width="50mm"/>
            <fo:table-column column-width="50mm"/>
            <fo:table-header>
              <fo:table-row>
                <fo:table-cell border-width="0.1mm" border-style="solid" ><fo:block font-weight="bold">Circuit ID</fo:block></fo:table-cell>
                <fo:table-cell border-width="0.1mm" border-style="solid" ><fo:block font-weight="bold">Speed</fo:block></fo:table-cell>
                <fo:table-cell border-width="0.1mm" border-style="solid" ><fo:block font-weight="bold">Location</fo:block></fo:table-cell>
              </fo:table-row>
            </fo:table-header>
            <fo:table-body>
              <xsl:for-each select="max:INCIDENT/max:MULTIASSETLOCCI">
                <fo:table-row>
                  <fo:table-cell border-width="0.1mm" border-style="solid" ><fo:block><xsl:value-of select="max:CINUM"/></fo:block></fo:table-cell>
                  <fo:table-cell border-width="0.1mm" border-style="solid" ><fo:block><xsl:text>100 Mbps</xsl:text></fo:block></fo:table-cell>
                  <fo:table-cell border-width="0.1mm" border-style="solid" ><fo:block><xsl:text>Bangkok</xsl:text></fo:block></fo:table-cell>
                </fo:table-row>
              </xsl:for-each>
            </fo:table-body>
          </fo:table>
        </fo:block>
        <!-- table end -->
      </xsl:if>
      <fo:block padding="3mm"/>
      <fo:block padding="1.5mm">
        <fo:inline>Resolve Date: </fo:inline>
        <fo:inline>
          <xsl:variable name="rdt" select="max:INCIDENT/max:ACTUALFINISH"/>
          <xsl:if test="$rdt != ''">
            <xsl:value-of select="concat(substring($rdt,9,2),'-',substring($rdt,6,2),'-',substring($rdt,1,4),' ',substring($rdt,12,2),':',substring($rdt, 15,2),':',substring($rdt,18,2))"/>
          </xsl:if>
        </fo:inline>
      </fo:block>
      <fo:block padding="1.5mm">
        <fo:block>Resolution Details:</fo:block>
                <xsl:variable name="replace1">
                        <xsl:call-template name="replace-string">
                          <xsl:with-param name="text" select="max:INCIDENT/max:FR2CODE_LONGDESCRIPTION"/>
                          <xsl:with-param name="replace" select="'&lt;br /&gt;'" />
                          <xsl:with-param name="with" select="''"/>
                        </xsl:call-template>
                </xsl:variable>
                <xsl:variable name="replace2">
                        <xsl:call-template name="replace-string">
                          <xsl:with-param name="text" select="$replace1"/>
                          <xsl:with-param name="replace" select="'&lt;!-- RICH TEXT --&gt;'" />
                          <xsl:with-param name="with" select="''"/>
                        </xsl:call-template>
                </xsl:variable>

        <fo:block><xsl:value-of select="$replace2"/></fo:block>
      </fo:block>
      <fo:block padding="3mm"/>
      <fo:block padding="1.5mm">
        <fo:block>Sincerely,</fo:block>
	<fo:block padding="6mm"/>
	<fo:block><xsl:value-of select="max:INCIDENT/max:OWNER"/></fo:block>
      </fo:block>
      <fo:block padding="3mm"/>
    </fo:block>
        </fo:flow>
      </fo:page-sequence>
    </fo:root>
  </xsl:template>
<xsl:template name="replace-string">
    <xsl:param name="text"/>
    <xsl:param name="replace"/>
    <xsl:param name="with"/>
    <xsl:choose>
      <xsl:when test="contains($text,$replace)">
        <xsl:value-of select="substring-before($text,$replace)"/>
        <xsl:value-of select="$with"/>
        <xsl:call-template name="replace-string">
          <xsl:with-param name="text"
select="substring-after($text,$replace)"/>
          <xsl:with-param name="replace" select="$replace"/>
          <xsl:with-param name="with" select="$with"/>
        </xsl:call-template>
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="$text"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
</xsl:stylesheet>
