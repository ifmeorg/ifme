<?xml version="1.0" ?>
<xsl:stylesheet xmlns:xsl="https://www.w3.org/1999/XSL/Transform" version="1.0"
    xmlns:svg="https://www.w3.org/2000/svg" xmlns="https://www.w3.org/2000/svg">
<xsl:output method="xml" indent="yes"
    doctype-public="-//W3C//DTD SVG 1.0//EN"
    doctype-system="https://www.w3.org/TR/2001/REC-SVG-20010904/DTD/svg10.dtd"/>

<xsl:template match="@*|node()">
  <xsl:copy>
    <xsl:apply-templates select="@*|node()"/>
  </xsl:copy> 
</xsl:template>

<xsl:template match="svg:svg">
  <svg xmlns="https://www.w3.org/2000/svg">
    <!-- Order is important here, so the attributes below overrides the 
         originals, which are copied "wholesale" -->
    <xsl:apply-templates select="@*" />
 
    <defs>
      <linearGradient id="white" x1="0%" y1="0%" x2="0%" y2="0%">
         <stop offset="0%" style="stop-color:rgb(255,255,255);stop-opacity:1"/>
      </linearGradient>

      <linearGradient id="aquamarine" x1="0%" y1="0%" x2="100%" y2="100%">
	<stop offset="0%" style="stop-color:rgb(255,255,255);stop-opacity:1"/>
	<stop offset="100%" style="stop-color:rgb(127,255,212);stop-opacity:1"/>
      </linearGradient>

      <linearGradient id="azure" x1="0%" y1="0%" x2="100%" y2="100%">
	<stop offset="0%" style="stop-color:rgb(255,255,255);stop-opacity:1"/>
	<stop offset="100%" style="stop-color:rgb(240,255,255);stop-opacity:1"/>
      </linearGradient>

      <linearGradient id="blue" x1="0%" y1="0%" x2="100%" y2="100%">
	<stop offset="0%" style="stop-color:rgb(255,255,255);stop-opacity:1"/>
	<stop offset="100%" style="stop-color:rgb(0,0,255);stop-opacity:1"/>
      </linearGradient>

      <linearGradient id="blueviolet" x1="0%" y1="0%" x2="100%" y2="100%">
	<stop offset="0%" style="stop-color:rgb(255,255,255);stop-opacity:1"/>
	<stop offset="100%" style="stop-color:rgb(138,43,226);stop-opacity:1"/>
      </linearGradient>

      <linearGradient id="brown" x1="0%" y1="0%" x2="100%" y2="100%">
	<stop offset="0%" style="stop-color:rgb(255,255,255);stop-opacity:1"/>
	<stop offset="100%" style="stop-color:rgb(165,42,42);stop-opacity:1"/>
      </linearGradient>

      <linearGradient id="cadetblue" x1="0%" y1="0%" x2="100%" y2="100%">
	<stop offset="0%" style="stop-color:rgb(255,255,255);stop-opacity:1"/>
	<stop offset="100%" style="stop-color:rgb(95,158,160);stop-opacity:1"/>
      </linearGradient>
      
      <linearGradient id="chocolate" x1="0%" y1="0%" x2="100%" y2="100%">
	<stop offset="0%" style="stop-color:rgb(255,255,255);stop-opacity:1"/>
	<stop offset="100%" style="stop-color:rgb(210,105,30);stop-opacity:1"/>
      </linearGradient>

      <linearGradient id="cornflowerblue" x1="0%" y1="0%" x2="100%" y2="100%">
	<stop offset="0%" style="stop-color:rgb(255,255,255);stop-opacity:1"/>
	<stop offset="100%" style="stop-color:rgb(100,149,237);stop-opacity:1"/>
      </linearGradient>
      
      <linearGradient id="crimson" x1="0%" y1="0%" x2="100%" y2="100%">
	<stop offset="0%" style="stop-color:rgb(255,255,255);stop-opacity:1"/>
	<stop offset="100%" style="stop-color:rgb(220,20,60);stop-opacity:1"/>
      </linearGradient>

      <linearGradient id="cyan" x1="0%" y1="0%" x2="100%" y2="100%">
	<stop offset="0%" style="stop-color:rgb(255,255,255);stop-opacity:1"/>
	<stop offset="100%" style="stop-color:rgb(0,255,255);stop-opacity:1"/>
      </linearGradient>

      <linearGradient id="darkgreen" x1="0%" y1="0%" x2="100%" y2="100%">
	<stop offset="0%" style="stop-color:rgb(255,255,255);stop-opacity:1"/>
	<stop offset="100%" style="stop-color:rgb(0,100,0);stop-opacity:1"/>
      </linearGradient>

      <linearGradient id="darkorange" x1="0%" y1="0%" x2="100%" y2="100%">
	<stop offset="0%" style="stop-color:rgb(255,255,255);stop-opacity:1"/>
	<stop offset="100%" style="stop-color:rgb(255,140,0);stop-opacity:1"/>
      </linearGradient>

      <linearGradient id="gold" x1="0%" y1="0%" x2="100%" y2="100%">
	<stop offset="0%" style="stop-color:rgb(255,255,255);stop-opacity:1"/>
	<stop offset="100%" style="stop-color:rgb(255,215,0);stop-opacity:1"/>
      </linearGradient>
      
      <linearGradient id="gray" x1="0%" y1="0%" x2="100%" y2="100%">
	<stop offset="0%" style="stop-color:rgb(255,255,255);stop-opacity:1"/>
	<stop offset="100%" style="stop-color:rgb(192,192,192);stop-opacity:1"/>
      </linearGradient>

      <linearGradient id="greenyellow" x1="0%" y1="0%" x2="100%" y2="100%">
	<stop offset="0%" style="stop-color:rgb(255,255,255);stop-opacity:1"/>
	<stop offset="100%" style="stop-color:rgb(173,255,47);stop-opacity:1"/>
      </linearGradient>

      <linearGradient id="green" x1="0%" y1="0%" x2="100%" y2="100%">
	<stop offset="0%" style="stop-color:rgb(255,255,255);stop-opacity:1"/>
	<stop offset="100%" style="stop-color:rgb(0,255,0);stop-opacity:1"/>
      </linearGradient>

      <linearGradient id="grey" x1="0%" y1="0%" x2="100%" y2="100%">
	<stop offset="0%" style="stop-color:rgb(255,255,255);stop-opacity:1"/>
	<stop offset="100%" style="stop-color:rgb(192,192,192);stop-opacity:1"/>
      </linearGradient>
      
      <linearGradient id="hotpink" x1="0%" y1="0%" x2="100%" y2="100%">
	<stop offset="0%" style="stop-color:rgb(255,255,255);stop-opacity:1"/>
	<stop offset="100%" style="stop-color:rgb(255,105,180);stop-opacity:1"/>
      </linearGradient>

      <linearGradient id="indianred" x1="0%" y1="0%" x2="100%" y2="100%">
	<stop offset="0%" style="stop-color:rgb(255,255,255);stop-opacity:1"/>
	<stop offset="100%" style="stop-color:rgb(205,92,92);stop-opacity:1"/>
      </linearGradient>

      <linearGradient id="indigo" x1="0%" y1="0%" x2="100%" y2="100%">
	<stop offset="0%" style="stop-color:rgb(255,255,255);stop-opacity:1"/>
	<stop offset="100%" style="stop-color:rgb(75,0,130);stop-opacity:1"/>
      </linearGradient>

      <linearGradient id="lavender" x1="0%" y1="0%" x2="100%" y2="100%">
	<stop offset="0%" style="stop-color:rgb(255,255,255);stop-opacity:1"/>
	<stop offset="100%" style="stop-color:rgb(230,230,250);stop-opacity:1"/>
      </linearGradient>

      <linearGradient id="lightblue" x1="0%" y1="0%" x2="100%" y2="100%">
	<stop offset="0%" style="stop-color:rgb(255,255,255);stop-opacity:1"/>
	<stop offset="100%" style="stop-color:rgb(173,216,230);stop-opacity:1"/>
      </linearGradient>

      <linearGradient id="lightgray" x1="0%" y1="0%" x2="100%" y2="100%">
	<stop offset="0%" style="stop-color:rgb(255,255,255);stop-opacity:1"/>
	<stop offset="100%" style="stop-color:rgb(211,211,211);stop-opacity:1"/>
      </linearGradient>
      
      <linearGradient id="lightgrey" x1="0%" y1="0%" x2="100%" y2="100%">
	<stop offset="0%" style="stop-color:rgb(255,255,255);stop-opacity:1"/>
	<stop offset="100%" style="stop-color:rgb(211,211,211);stop-opacity:1"/>
      </linearGradient>

      <linearGradient id="magenta" x1="0%" y1="0%" x2="100%" y2="100%">
	<stop offset="0%" style="stop-color:rgb(255,255,255);stop-opacity:1"/>
	<stop offset="100%" style="stop-color:rgb(255,0,255);stop-opacity:1"/>
      </linearGradient>
      
      <linearGradient id="maroon" x1="0%" y1="0%" x2="100%" y2="100%">
	<stop offset="0%" style="stop-color:rgb(255,255,255);stop-opacity:1"/>
	<stop offset="100%" style="stop-color:rgb(176,48,96);stop-opacity:1"/>
      </linearGradient>
      
      <linearGradient id="mediumblue" x1="0%" y1="0%" x2="100%" y2="100%">
	<stop offset="0%" style="stop-color:rgb(255,255,255);stop-opacity:1"/>
	<stop offset="100%" style="stop-color:rgb(0,0,205);stop-opacity:1"/>
      </linearGradient>
      
      <linearGradient id="mediumpurple" x1="0%" y1="0%" x2="100%" y2="100%">
	<stop offset="0%" style="stop-color:rgb(255,255,255);stop-opacity:1"/>
	<stop offset="100%" style="stop-color:rgb(147,112,219);stop-opacity:1"/>
      </linearGradient>

      <linearGradient id="orange" x1="0%" y1="0%" x2="100%" y2="100%">
	<stop offset="0%" style="stop-color:rgb(255,255,255);stop-opacity:1"/>
	<stop offset="100%" style="stop-color:rgb(255,165,0);stop-opacity:1"/>
      </linearGradient>

      <linearGradient id="pink" x1="0%" y1="0%" x2="100%" y2="100%">
	<stop offset="0%" style="stop-color:rgb(255,255,255);stop-opacity:1"/>
	<stop offset="100%" style="stop-color:rgb(255,192,203);stop-opacity:1"/>
      </linearGradient>
      
      <linearGradient id="purple" x1="0%" y1="0%" x2="100%" y2="100%">
	<stop offset="0%" style="stop-color:rgb(255,255,255);stop-opacity:1"/>
	<stop offset="100%" style="stop-color:rgb(160,32,240);stop-opacity:1"/>
      </linearGradient>

      <linearGradient id="red" x1="0%" y1="0%" x2="100%" y2="100%">
	<stop offset="0%" style="stop-color:rgb(255,255,255);stop-opacity:1"/>
	<stop offset="100%" style="stop-color:rgb(255,0,0);stop-opacity:1"/>
      </linearGradient>
      
      <linearGradient id="steelblue" x1="0%" y1="0%" x2="100%" y2="100%">
	<stop offset="0%" style="stop-color:rgb(255,255,255);stop-opacity:1"/>
	<stop offset="100%" style="stop-color:rgb(70,130,180);stop-opacity:1"/>
      </linearGradient>
      
      <linearGradient id="violet" x1="0%" y1="0%" x2="100%" y2="100%">
	<stop offset="0%" style="stop-color:rgb(255,255,255);stop-opacity:1"/>
	<stop offset="100%" style="stop-color:rgb(238,130,238);stop-opacity:1"/>
      </linearGradient>

      <linearGradient id="yellow" x1="0%" y1="0%" x2="100%" y2="100%">
	<stop offset="0%" style="stop-color:rgb(255,255,255);stop-opacity:1"/>
	<stop offset="100%" style="stop-color:rgb(255,255,0);stop-opacity:1"/>
      </linearGradient>

      <linearGradient id="none" x1="0%" y1="0%" x2="100%" y2="100%">
         <stop offset="0%" style="stop-color:rgb(255,255,255);stop-opacity:1"/>
         <stop offset="100%" style="stop-color:rgb(255,255,255);stop-opacity:1"/>
      </linearGradient>
    </defs>

    <xsl:apply-templates />
  </svg>
</xsl:template>

<!-- Match the top most "g" -->
<xsl:template match="/svg:svg/svg:g"> 
  <g>
    <xsl:apply-templates select="@*"/>
    <!-- Graphviz uses a polygon as the background. Don't want a gradient there -->
    <xsl:for-each select="svg:polygon">
      <xsl:copy><xsl:apply-templates select="@*" /></xsl:copy>
    </xsl:for-each>
    <xsl:apply-templates select="svg:title|svg:g" />
  </g>
</xsl:template> 
 

<xsl:template match="svg:text">
  <text>
    <xsl:apply-templates select="@*" />
    <xsl:attribute name="style">font-size:10px; font-family:Verdana</xsl:attribute> 
    <xsl:apply-templates select="text()"/>
  </text>
</xsl:template> 


<xsl:template match="svg:g">
  <xsl:copy>
    <xsl:apply-templates select="@*" />

    <xsl:for-each select="svg:polygon|svg:ellipse">
      <xsl:call-template name="poly-shadow" />
    </xsl:for-each>

    <xsl:choose>
      <xsl:when test="@class='node'">
	<xsl:for-each select="svg:path">
	  <xsl:call-template name="path-shadow" />
	</xsl:for-each>
      </xsl:when>
      <xsl:otherwise>
	<xsl:for-each select="svg:path">
	  <xsl:call-template name="path-shadow-edge" />
	</xsl:for-each>
      </xsl:otherwise>
    </xsl:choose>
  
    <xsl:for-each select="svg:polygon|svg:ellipse|svg:polyline">
      <xsl:sort select="@ry" order="descending" />
      <xsl:call-template name="poly-main" />
    </xsl:for-each>

    <xsl:choose>
      <xsl:when test="@class='node'">
	<xsl:for-each select="svg:path">
	  <xsl:call-template name="path-main" />
	</xsl:for-each>
      </xsl:when>
      <xsl:otherwise>
	<xsl:for-each select="svg:path">
        <path><xsl:apply-templates select="@*" /></path>
	</xsl:for-each>
      </xsl:otherwise>
    </xsl:choose>

    <xsl:apply-templates select="svg:text" />
  </xsl:copy>
</xsl:template>

<xsl:template name="poly-shadow">
        <xsl:element name="{name()}">
          <xsl:apply-templates select="@*"/>
          <xsl:attribute name="style">fill: black; stroke: none; fill-opacity:0.3</xsl:attribute> 
          <xsl:attribute name="transform">translate(3,3)</xsl:attribute>
        </xsl:element>
</xsl:template>

<xsl:template name="path-shadow">
        <xsl:element name="{name()}">
          <xsl:apply-templates select="@*"/>
	  <!-- For some reason this comes out twice, so the opacity is set to 0.15 instead of 0.3 -->
          <xsl:attribute name="style">fill: black; stroke: none; fill-opacity:0.15</xsl:attribute> 
          <xsl:attribute name="transform">translate(3,3)</xsl:attribute>
        </xsl:element>
</xsl:template>

<xsl:template name="path-shadow-edge">
        <xsl:element name="{name()}">
          <xsl:apply-templates select="@*"/>
          <xsl:attribute name="style">fill: none; stroke: black; stroke-opacity:0.3</xsl:attribute> 
          <xsl:attribute name="transform">translate(3,3)</xsl:attribute>
        </xsl:element>
</xsl:template>

<xsl:template name="poly-main">
  <xsl:element name="{name()}">
    <xsl:apply-templates select="@*" />
    <xsl:choose>
      <xsl:when test="@fill != ''">
<xsl:attribute name="style">fill:url(#<xsl:value-of select="@fill"/>);stroke:black;</xsl:attribute></xsl:when>
      <xsl:otherwise><xsl:attribute name="style">fill:url(#<xsl:value-of select="normalize-space(substring-after(substring-before(@style,';'),'fill:'))"/>);stroke:<xsl:value-of select="normalize-space(substring-after(substring-after(@style,';'),'stroke:'))"/>;</xsl:attribute></xsl:otherwise>
    </xsl:choose>
  </xsl:element>
</xsl:template>

<xsl:template name="path-main">
        <path>
          <xsl:apply-templates select="@*" />
	  <!-- This is somewhat broken - the gradient is set based on the position/size of the element it is used with; as a result it doesn't line up properly with the main polygon -->
	  <xsl:attribute name="style">fill:url(#<xsl:value-of select="normalize-space(substring-after(substring-before(../svg:polygon/@style,';'),'fill:'))"/>);stroke:black;</xsl:attribute>
        </path>
</xsl:template>

</xsl:stylesheet>

 
