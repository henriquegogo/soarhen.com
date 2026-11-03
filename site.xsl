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
  padding: 30px;
  color: #CCC;
  background: #111;
  border-radius: 12px;
}
img {
  max-width: 100%;
  border: none;
  border-radius: 12px;
}
</style>
    </xsl:variable>

    <xsl:variable name="footer">
<a href="/feed.xml">RSS</a> - <a href="#" onclick="location.href='mailto:'+['.com','soarhen','@','henrique'].reverse().join('')">Contact</a>
    </xsl:variable>

    <xsl:template match="/atom:feed">

        <!-- INDEX -->
        <exsl:document href="index.html" method="html" encoding="UTF-8" indent="yes">
<html lang="en">
  <head>
    <xsl:copy-of select="$head"/>
    <title><xsl:value-of select="atom:title"/></title>
  </head>
  <body>
    <header><a href="/">HENRIQUE SOARES</a></header>
    <xsl:for-each select="atom:entry">
      <xsl:variable name="slug" select="substring-after(atom:id, 'https://soarhen.com/')"/>
      <p>
        <time><xsl:value-of select="atom:updated"/></time> - 
        <a href="/{$slug}/"><xsl:value-of select="atom:title"/></a>
      </p>
    </xsl:for-each>
    <footer><xsl:copy-of select="$footer"/></footer>
  </body>
</html>
        </exsl:document>

        <!-- POSTS -->
        <xsl:for-each select="atom:entry">
            <xsl:variable name="slug" select="substring-after(atom:id, 'https://soarhen.com/')"/>
            <xsl:variable name="filename" select="concat($slug, '/index.html')"/>
            <exsl:document href="{$filename}" method="html" encoding="UTF-8" indent="yes">
<html lang="en">
  <head>
    <xsl:copy-of select="$head"/>
    <title><xsl:value-of select="atom:title"/> - Henrique Soares</title>
  </head>
  <body>
    <header><a href="/">HENRIQUE SOARES</a></header>
    <h1><xsl:value-of select="atom:title"/></h1>
    <time><xsl:value-of select="atom:updated"/></time>
    <xsl:value-of select="atom:content" disable-output-escaping="yes"/>
    <footer><xsl:copy-of select="$footer"/></footer>
  </body>
</html>
            </exsl:document>
        </xsl:for-each>

    </xsl:template>
</xsl:stylesheet>
