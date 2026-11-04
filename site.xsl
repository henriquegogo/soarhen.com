<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" 
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:atom="http://www.w3.org/2005/Atom"
    xmlns:exsl="http://exslt.org/common"
    extension-element-prefixes="exsl"
    exclude-result-prefixes="atom">

    <xsl:output method="html" encoding="UTF-8" indent="yes"/>

    <xsl:variable name="head">

<meta charset="utf-8"/>
<meta name="viewport" content="width=device-width, initial-scale=1"/>
<link rel="alternate" type="application/atom+xml" title="Feed" href="https://soarhen.com/feed.xml"/>
<style>
html {
  font-family: monospace;
  font-size: 1.1rem;
  line-height: 1.3;
  color: #444;
  background: #DDE;
}
body {
  margin: 0 auto;
  padding: 20px;
  max-width: 800px;
}
header {
  width: 66%;
  margin-bottom: 30px;
  padding-bottom: 5px;
  color: #99B;
  border-bottom: 2px solid #BBD;
}
header a {
  color: #99B;
  text-decoration: none;
  text-transform: uppercase;
}
footer {
  width: 66%;
  margin-top: 30px;
  margin-left: 33%;
  padding-top: 5px;
  color: #99B;
  text-align: right;
  border-top: 2px solid #BBD;
}
footer a {
  color: #99B;
  text-decoration: none;
}
h1, h2, h3, h4, h5, h6 {
  margin-top: 40px;
  font-size: 1.1rem; 
  text-transform: uppercase;
}
h1, h2, h3, h4, h5, h6, b, i, strong, em {
  color: #000;
}
h1 { margin: 0; font-size: 1.2rem; }
time { font-size: 0.9rem; color: #888; }
a { color: #44B; }
li { margin: 0.5rem 0; }
pre code {
  display: block;
  padding: 10px 30px;
  color: #CCC;
  background: #111;
  border-radius: 12px;
  overflow: auto;
}
img {
  max-width: 100%;
  border: none;
  border-radius: 12px;
}
</style>

    </xsl:variable>

    <xsl:template name="footer">

      <footer>
        <xsl:for-each select="/site/pages/page">
          <a href="{@path}"><xsl:value-of select="@title"/></a> - 
        </xsl:for-each>
        <a href="/feed.xml">RSS</a>
      </footer>

    </xsl:template>

    <xsl:template match="/site">

        <!-- INDEX -->
        <exsl:document href="index.html" method="html" encoding="UTF-8" indent="yes">

<html lang="en">
  <head>
    <xsl:copy-of select="$head"/>
    <title><xsl:value-of select="@title"/></title>
  </head>
  <body>
    <header><a href="{@url}"><xsl:value-of select="@title"/></a></header>
    <xsl:for-each select="posts/post">
      <p>
        <time><xsl:value-of select="@date"/></time><br/> 
        <a href="{@path}"><xsl:value-of select="@title"/></a>
      </p>
    </xsl:for-each>
    <xsl:call-template name="footer"/>
  </body>
</html>

        </exsl:document>

        <!-- POSTS -->
        <xsl:for-each select="posts/post">
            <xsl:variable name="filename" select="concat(substring(@path, 2), '/index.html')"/>
            <exsl:document href="{$filename}" method="html" encoding="UTF-8" indent="yes">

<html lang="en">
  <head>
    <xsl:copy-of select="$head"/>
    <title><xsl:value-of select="@title"/> - <xsl:value-of select="/site/@title"/></title>
  </head>
  <body>
    <header><a href="{/site/@url}"><xsl:value-of select="/site/@title"/></a></header>
    <h1><xsl:value-of select="@title"/></h1>
    <time><xsl:value-of select="@date"/></time>
    <xsl:value-of select="." disable-output-escaping="yes"/>
    <xsl:call-template name="footer"/>
  </body>
</html>

            </exsl:document>
        </xsl:for-each>

        <!-- PAGES -->
        <xsl:for-each select="pages/page">
            <xsl:variable name="filename" select="concat(substring(@path, 2), '/index.html')"/>
            <exsl:document href="{$filename}" method="html" encoding="UTF-8" indent="yes">

<html lang="en">
  <head>
    <xsl:copy-of select="$head"/>
    <title><xsl:value-of select="@title"/> - <xsl:value-of select="/site/@title"/></title>
  </head>
  <body>
    <header><a href="{/site/@url}"><xsl:value-of select="/site/@title"/></a></header>
    <h1><xsl:value-of select="@title"/></h1>
    <xsl:value-of select="." disable-output-escaping="yes"/>
    <xsl:call-template name="footer"/>
  </body>
</html>

            </exsl:document>
        </xsl:for-each>

        <exsl:document href="feed.xml" method="xml" encoding="UTF-8" indent="yes">

<feed xmlns="http://www.w3.org/2005/Atom">
    <title><xsl:value-of select="@title"/></title>
    <link href="{@url}/"/>
    <link rel="self" href="{@url}/feed.xml"/>
    <id><xsl:value-of select="@url"/>/</id>
    <updated><xsl:value-of select="posts/post[1]/@date"/></updated>
    <xsl:for-each select="posts/post">
    <entry>
        <title><xsl:value-of select="@title"/></title>
        <link href="{//site/@url}{@path}"/>
        <id>urn:uuid:<xsl:value-of select="substring(@path, 2)"/></id>
        <updated><xsl:value-of select="@date"/>T00:00:00Z</updated>
        <content type="html">
            <xsl:text disable-output-escaping="yes">&lt;![CDATA[</xsl:text>
            <xsl:value-of select="." disable-output-escaping="yes"/>
            <xsl:text disable-output-escaping="yes">]]&gt;</xsl:text>
        </content>
    </entry>
    </xsl:for-each>
</feed>

        </exsl:document>

    </xsl:template>
</xsl:stylesheet>
