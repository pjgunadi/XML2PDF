# XML2PDF
XML2PDF is a simple java application for converting XML content into PDF using XSL-FO (XSL Formatting Objects) translation.  
The PDF can be rendered with True Type fonts with input configuration file and the fonts should have been installed on the running machine.  
The code implements Apache FOP. For more information about Apache FOP: https://xmlgraphics.apache.org/fop/  
More information on configuring fonts: https://xmlgraphics.apache.org/fop/2.2/fonts.html  

Inputs
------
- XML File
- XSL-FO translation file
- Configuration file (optional)  
**Note: XSL-FO translation will vary depending on the XML format.

Usage Guide
------------
//Create instance with config file:  
xp = new XML2PDF("/path/to/config/file");  

//Create instance without config file:  
xp = new XML2PDF();  

//Transform to PDF:  
xp.transform("/path/to/source/xml/file","/path/to/xsl-fo/translator/file","/path/to/target/pdf/file");

Samples
-------
- Source XML: incident.xml
- XSL-FO file: inc2fo.xsl
- Result: incident.pdf
