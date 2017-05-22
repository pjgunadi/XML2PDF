import com.ibm.custom.XML2PDF as XML2PDF

#create instance with one of these two methods
#xp = XML2PDF() 
xp = XML2PDF('etc/fop.xconf')

#file locations:
xmlpath = 'samples/incident.xml'
xsltpath = 'samples/inc2fo.xsl'
pdfpath = 'samples/jython_result.pdf'
xp.transform(xmlpath,xsltpath,pdfpath)
