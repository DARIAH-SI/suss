<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet 
   xmlns="http://www.w3.org/1999/xhtml"
   xmlns:html="http://www.w3.org/1999/xhtml"
   xmlns:tei="http://www.tei-c.org/ns/1.0"
   xmlns:teidocx="http://www.tei-c.org/ns/teidocx/1.0"
   xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
   xmlns:xs="http://www.w3.org/2001/XMLSchema"
   exclude-result-prefixes="tei html teidocx xs"
   version="2.0">

   <xsl:import href="../../../../pub-XSLT/Stylesheets/html5-foundation6-chs/to.xsl"/>
   
   <doc xmlns="http://www.oxygenxml.com/ns/doc/xsl" scope="stylesheet" type="stylesheet">
      <desc>
         <p>TEI stylesheet for making HTML5 output (Zurb Foundation 6 http://foundation.zurb.com/sites/docs/).</p>
         <p>This software is dual-licensed:
            
            1. Distributed under a Creative Commons Attribution-ShareAlike 3.0
            Unported License http://creativecommons.org/licenses/by-sa/3.0/ 
            
            2. http://www.opensource.org/licenses/BSD-2-Clause
            
            
            
            Redistribution and use in source and binary forms, with or without
            modification, are permitted provided that the following conditions are
            met:
            
            * Redistributions of source code must retain the above copyright
            notice, this list of conditions and the following disclaimer.
            
            * Redistributions in binary form must reproduce the above copyright
            notice, this list of conditions and the following disclaimer in the
            documentation and/or other materials provided with the distribution.
            
            This software is provided by the copyright holders and contributors
            "as is" and any express or implied warranties, including, but not
            limited to, the implied warranties of merchantability and fitness for
            a particular purpose are disclaimed. In no event shall the copyright
            holder or contributors be liable for any direct, indirect, incidental,
            special, exemplary, or consequential damages (including, but not
            limited to, procurement of substitute goods or services; loss of use,
            data, or profits; or business interruption) however caused and on any
            theory of liability, whether in contract, strict liability, or tort
            (including negligence or otherwise) arising in any way out of the use
            of this software, even if advised of the possibility of such damage.
         </p>
         <p>Andrej Pančur, Institute for Contemporary History</p>
         <p>Copyright: 2013, TEI Consortium</p>
      </desc>
   </doc>
  
   <!-- Uredi parametre v skladu z dodatnimi zahtevami za pretvorbo te publikacije: -->
   <!-- https://www2.sistory.si/publikacije/ -->
   <!-- ../../../  -->
   <xsl:param name="path-general">https://www2.sistory.si/publikacije/</xsl:param>
   
   <!-- Iz datoteke ../../../../publikacije-XSLT/sistory/html5-foundation6-chs/to.xsl -->
   <xsl:param name="outputDir">docs/</xsl:param>
   
   <xsl:param name="homeLabel">ŠUSS</xsl:param>
   <xsl:param name="homeURL">https://dariah-si.github.io/suss/</xsl:param>
   
   <xsl:param name="splitLevel">0</xsl:param>
   
   <!-- Iz datoteke ../../../../publikacije-XSLT/sistory/html5-foundation6-chs/my-html_param.xsl -->
   <xsl:param name="title-bar-sticky">false</xsl:param>
   
   <xsl:param name="chapterAsSIstoryPublications">false</xsl:param>
   
   <!-- odstranim pri spodnjih param true -->
   <xsl:param name="numberFigures"></xsl:param>
   <xsl:param name="numberFrontTables"></xsl:param>
   <xsl:param name="numberHeadings"></xsl:param>
   <xsl:param name="numberParagraphs">true</xsl:param>
   <xsl:param name="numberTables"></xsl:param>
   
   <!-- V html/head izpisani metapodatki -->
   <xsl:param name="description">Arhiv vprašanj in odgovorov o slovenskem jeziku ŠUSS (1998-2010); The ŠUSS archive of questions and answers about the Slovenian language (1998-2010)</xsl:param>
   <xsl:param name="keywords">Slovenščina, slovnica, jezik</xsl:param>
   <xsl:param name="title">Arhiv vprašanj in odgovorov o slovenskem jeziku ŠUSS (1998-2010)</xsl:param>
   
   <xsldoc:doc xmlns:xsldoc="http://www.oxygenxml.com/ns/doc/xsl">
      <xsldoc:desc>V css Hook dodam še nokej porjektno specifičnih CSS</xsldoc:desc>
   </xsldoc:doc>
   <xsl:template name="cssHook">
      <xsl:if test="$title-bar-sticky = 'true'">
         <xsl:value-of select="concat($path-general,'themes/css/foundation/6/sistory-sticky_title_bar.css')"/>
      </xsl:if>
      <link href="https://cdnjs.cloudflare.com/ajax/libs/foundicons/3.0.0/foundation-icons.min.css" rel="stylesheet" type="text/css" />
      <link href="{concat($path-general,'themes/plugin/TipueSearch/6.1/tipuesearch/css/normalize.css')}" rel="stylesheet" type="text/css" />
      <link href="{concat($path-general,'themes/css/plugin/TipueSearch/6.1/my-tipuesearch.css')}"  rel="stylesheet" type="text/css" />
      <!-- dodam za povezave na same sebe -->
      <style>
         .selflink:hover { opacity: 0.5;}
         .keywordlink:hover { opacity: 0.5;}
         .numberParagraphLink {text-decoration: none;}
         .numberParagraph:hover {color: black;}
      </style>
   </xsl:template>
   
   <doc xmlns="http://www.oxygenxml.com/ns/doc/xsl">
      <desc>Novo ime za glavno vsebino (glavna navigacija)</desc>
      <param name="thisLanguage"></param>
   </doc>
   <xsl:template name="nav-body-head">
      <xsl:param name="thisLanguage"/>
      <xsl:text>Jezikoslovna vprašanja in odgovori</xsl:text>
   </xsl:template>
   
   <doc xmlns="http://www.oxygenxml.com/ns/doc/xsl">
      <desc>Novo ime za indekse (krajevnih, osebnih, organizacij)</desc>
      <param name="thisLanguage"></param>
   </doc>
   <xsl:template name="nav-index-head">
      <xsl:param name="thisLanguage"/>
      <xsl:text>Ključne besede</xsl:text>
   </xsl:template>
   
   <doc xmlns="http://www.oxygenxml.com/ns/doc/xsl">
      <desc>Procesiram ključne besede kot label</desc>
   </doc>
   <xsl:template match="tei:list[@type='keywords']">
      <xsl:variable name="keywords-file-id">keywords</xsl:variable>
      <xsl:variable name="sistoryPath">
         <xsl:if test="$chapterAsSIstoryPublications='true'">
            <xsl:call-template name="sistoryPath">
               <xsl:with-param name="chapterID" select="$keywords-file-id"/>
            </xsl:call-template>
         </xsl:if>
      </xsl:variable>
      <p>
         <xsl:for-each select="tei:item">
            <a id="{@xml:id}" href="{concat($sistoryPath,$keywords-file-id,'.html#',translate(translate(.,' /()',''),'čšžČŠŽ','cszCSZ'))}" class="keywordlink">
               <span class="label secondary">
                  <xsl:value-of select="."/>
               </span>
            </a>
            <xsl:text> </xsl:text>
         </xsl:for-each>
      </p>
   </xsl:template>
   
   <doc xmlns="http://www.oxygenxml.com/ns/doc/xsl">
      <desc>Procesiranje specifilnih vsebinskih podpoglavij</desc>
   </doc>
   <xsl:template match="tei:div[@type='question' or @type='answer' or @type='comment' or @type='reference']">
      <xsl:variable name="divType">
         <xsl:choose>
            <xsl:when test="@type='question'">alert</xsl:when>
            <xsl:when test="@type='answer'">success</xsl:when>
            <xsl:when test="@type='comment'">secondary</xsl:when>
         </xsl:choose>
      </xsl:variable>
      <div id="{@xml:id}" class="{@type}{if (@type != 'reference') then ' callout ' else ''}{$divType}">
         <a href="#{@xml:id}" class="selflink" title="Povezava na ta razdelek">
            <span class="badge {if (@type != 'reference') then $divType else 'primary'}">
               <xsl:choose>
                  <xsl:when test="@type='question'">vprašanje</xsl:when>
                  <xsl:when test="@type='answer'">odgovor</xsl:when>
                  <xsl:when test="@type='comment'">komentar</xsl:when>
                  <xsl:when test="@type='reference'">navedbe</xsl:when>
               </xsl:choose>
            </span>
         </a>
         <xsl:apply-templates/>
      </div>
   </xsl:template>
   
   <doc xmlns="http://www.oxygenxml.com/ns/doc/xsl">
      <desc>Dodam procesiranje za indeks ključnih besed</desc>
      <param name="thisLanguage"></param>
   </doc>
   <xsl:template name="divGen-main-content">
      <xsl:param name="thisLanguage"/>
      <!-- kolofon CIP -->
      <xsl:if test="self::tei:divGen[@type='cip']">
         <xsl:apply-templates select="ancestor::tei:TEI/tei:teiHeader/tei:fileDesc" mode="kolofon"/>
      </xsl:if>
      <!-- TEI kolofon -->
      <xsl:if test="self::tei:divGen[@type='teiHeader']">
         <xsl:apply-templates select="ancestor::tei:TEI/tei:teiHeader"/>
      </xsl:if>
      <!-- kazalo vsebine toc -->
      <xsl:if test="self::tei:divGen[@type='toc'][@xml:id='toc'] | self::tei:divGen[@type='toc'][tokenize(@xml:id,'-')[last()]='toc']">
         <xsl:choose>
            <xsl:when test="$languages-locale='true'">
               <xsl:call-template name="mainTOC-my">
                  <xsl:with-param name="thisLanguage" select="$thisLanguage"/>
               </xsl:call-template>
            </xsl:when>
            <xsl:otherwise>
               <xsl:call-template name="mainTOC"/>
            </xsl:otherwise>
         </xsl:choose>
      </xsl:if>
      <!-- kazalo slik -->
      <xsl:if test="self::tei:divGen[@type='toc'][@xml:id='images'] | self::tei:divGen[@type='toc'][tokenize(@xml:id,'-')[last()]='images']">
         <xsl:call-template name="images">
            <xsl:with-param name="thisLanguage" select="$thisLanguage"/>
         </xsl:call-template>
      </xsl:if>
      <!-- kazalo grafikonov -->
      <xsl:if test="self::tei:divGen[@type='toc'][@xml:id='charts'] | self::tei:divGen[@type='toc'][tokenize(@xml:id,'-')[last()]='charts']">
         <xsl:call-template name="charts">
            <xsl:with-param name="thisLanguage" select="$thisLanguage"/>
         </xsl:call-template>
      </xsl:if>
      <!-- kazalo tabel -->
      <xsl:if test="self::tei:divGen[@type='toc'][@xml:id='tables'] | self::tei:divGen[@type='toc'][tokenize(@xml:id,'-')[last()]='tables']">
         <xsl:call-template name="tables">
            <xsl:with-param name="thisLanguage" select="$thisLanguage"/>
         </xsl:call-template>
      </xsl:if>
      <!-- kazalo vsebine toc, ki izpiše samo glavne naslove poglavij, skupaj z imeni avtorjev poglavij -->
      <xsl:if test="self::tei:divGen[@type='toc'][@xml:id='titleAuthor'] | self::tei:divGen[@type='toc'][tokenize(@xml:id,'-')[last()]='titleAuthor']">
         <xsl:call-template name="TOC-title-author"/>
      </xsl:if>
      <!-- kazalo vsebine toc, ki izpiše samo naslove poglavij, kjer ima div atributa type in xml:id -->
      <xsl:if test="self::tei:divGen[@type='toc'][@xml:id='titleType'] | self::tei:divGen[@type='toc'][tokenize(@xml:id,'-')[last()]='titleType']">
         <xsl:call-template name="TOC-title-type"/>
      </xsl:if>
      <!-- prazen divGen, v katerem lahko naknadno poljubno procesiramo vsebino -->
      <xsl:if test="self::tei:divGen[@type='content']">
         <xsl:call-template name="divGen-process-content"/>
      </xsl:if>
      <!-- seznam (indeks) oseb -->
      <xsl:if test="self::tei:divGen[@type='index'][@xml:id='persons'] | self::tei:divGen[@type='index'][tokenize(@xml:id,'-')[last()]='persons']">
         <xsl:call-template name="persons"/>
      </xsl:if>
      <!-- seznam (indeks) krajev -->
      <xsl:if test="self::tei:divGen[@type='index'][@xml:id='places'] | self::tei:divGen[@type='index'][tokenize(@xml:id,'-')[last()]='places']">
         <xsl:call-template name="places"/>
      </xsl:if>
      <!-- seznam (indeks) organizacij -->
      <xsl:if test="self::tei:divGen[@type='index'][@xml:id='organizations'] | self::tei:divGen[@type='index'][tokenize(@xml:id,'-')[last()]='organizations']">
         <xsl:call-template name="organizations"/>
      </xsl:if>
      <!-- DODATNO: indeks ključnih besed -->
      <xsl:if test="self::tei:divGen[@type='index'][@xml:id='keywords'] | self::tei:divGen[@type='index'][tokenize(@xml:id,'-')[last()]='keywords']">
         <xsl:call-template name="keywords"/>
      </xsl:if>
      <!-- iskalnik -->
      <xsl:if test="self::tei:divGen[@type='search']">
         <xsl:call-template name="search"/>
      </xsl:if>
   </xsl:template>
   
   <doc xmlns="http://www.oxygenxml.com/ns/doc/xsl">
      <desc>Procesiranje novega indeska ključnih besed</desc>
   </doc>
   <xsl:template name="keywords">
      <ul style="list-style-type:none;">
         <xsl:for-each-group select="//tei:list[@type='keywords']/tei:item" group-by=".">
            <xsl:sort select="." lang="sl"/>
            <li id="{translate(translate(current-grouping-key(),' /()',''),'čšžČŠŽ','cszCSZ')}">
               <xsl:value-of select="current-grouping-key()"/>
               <!-- prazen prostor (pet praznih znakov) pred navajanji, kje je oseba zapisana -->
               <xsl:text disable-output-escaping="yes"><![CDATA[&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;]]></xsl:text>
               <xsl:for-each select="current-group()">
                  <xsl:variable name="ancestorChapter-id" select="ancestor::tei:div[@xml:id][parent::tei:front | parent::tei:body | parent::tei:back]/@xml:id"/>
                  <xsl:variable name="keywordId" select="@xml:id"/>
                  <xsl:variable name="sistoryPath">
                     <xsl:if test="$chapterAsSIstoryPublications='true'">
                        <xsl:call-template name="sistoryPath">
                           <xsl:with-param name="chapterID" select="$ancestorChapter-id"/>
                        </xsl:call-template>
                     </xsl:if>
                  </xsl:variable>
                  <a href="{concat($sistoryPath,$ancestorChapter-id,'.html#',$keywordId)}">
                     <xsl:value-of select="position()"/>
                  </a>
                  <xsl:if test="position() != last()">
                     <xsl:text>, </xsl:text>
                  </xsl:if>
               </xsl:for-each>
            </li>
         </xsl:for-each-group>
      </ul>
   </xsl:template>
   
   <doc xmlns="http://www.oxygenxml.com/ns/doc/xsl">
      <desc>How to number paragraphs: ga bom predrogačil na način, da bo omogočil linke na samega sebe</desc>
   </doc>
   <xsl:template name="numberParagraph">
      <xsl:choose>
         <xsl:when test="@xml:id and $numberParagraphs='true'">
            <!-- dodam zunanji span in nato a -->
            <span>
               <a href="#{@xml:id}" title="povezava na ta odstavek" class="numberParagraphLink">
                  <span class="numberParagraph">
                     <xsl:number/>
                  </span>
               </a>
            </span>
         </xsl:when>
         <xsl:otherwise>
            <span class="numberParagraph">
               <xsl:number/>
            </span>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:template>
   
   <doc xmlns="http://www.oxygenxml.com/ns/doc/xsl" class="hook">
      <desc>[common] Hook where actions can be inserted when making
         a heading: originalno je prazen in sem ga dopolnil po vzoru procesiranja odd</desc>
   </doc>
   <xsl:template name="sectionHeadHook">
      <xsl:variable name="ident">
         <xsl:apply-templates mode="ident" select="."/>
      </xsl:variable>
      <xsl:variable name="d">
         <xsl:apply-templates mode="depth" select="."/>
      </xsl:variable>
      <xsl:if test="$d &gt; 0">
         <span class="bookmarklink">
            <a class="bookmarklink" href="#{$ident}">
               <xsl:attribute name="title">
                  <xsl:text>povezava na ta razdelek </xsl:text>
               </xsl:attribute>
               <span class="invisible">
                  <xsl:text>TEI: </xsl:text>
                  <xsl:value-of select="tei:head[1]"/>
               </span>
               <span class="pilcrow">
                  <xsl:text>¶</xsl:text>
               </span>
            </a>
         </span>
      </xsl:if>
   </xsl:template>
   
   
</xsl:stylesheet>
