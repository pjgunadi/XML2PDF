package com.ibm.custom;
//maintained by Paulus Gunadi (paulus@sg.ibm.com)

import java.io.File;
import java.io.OutputStream;

import javax.xml.transform.Result;
import javax.xml.transform.Source;
import javax.xml.transform.Transformer;
import javax.xml.transform.TransformerFactory;
import javax.xml.transform.sax.SAXResult;
import javax.xml.transform.stream.StreamSource;
//import javax.xml.transform.dom.DOMSource;

import org.apache.fop.apps.FOUserAgent;
import org.apache.fop.apps.Fop;
import org.apache.fop.apps.FopFactory;
import org.apache.fop.apps.MimeConstants;

//import org.w3c.dom.Document;
//import org.w3c.dom.Node;

public class XML2PDF {

    private FopFactory fopFactory = null;
    private FOUserAgent foUserAgent = null;

    public XML2PDF() {
        fopFactory = FopFactory.newInstance(new File(".").toURI());
        foUserAgent = fopFactory.newFOUserAgent();
    }

    public XML2PDF(String strcfg) throws Exception {
        File cfgfile = new File(strcfg);
        fopFactory = FopFactory.newInstance(cfgfile);
        foUserAgent = fopFactory.newFOUserAgent();
    }

    public FOUserAgent getUserAgent() {
        return foUserAgent;
    }

    public void transform(String strxml, String strxsl, String strpdf) throws Exception {
        OutputStream out = null;
        try {
            //Identify Source
            Source src = null;
            if (strxml.toLowerCase().startsWith("http")) {
                src = new StreamSource(strxml); //URL Source
            } else {
                File xmlfile = new File(strxml);
                src = new StreamSource(xmlfile);
            }

            //Prepare Output
            File pdffile = new File(strpdf);
            out = new java.io.FileOutputStream(pdffile);
            out = new java.io.BufferedOutputStream(out);

            // Construct fop with desired output format
            Fop fop = fopFactory.newFop(MimeConstants.MIME_PDF, foUserAgent, out);

            // Setup XSLT
            File xsltfile = new File(strxsl);
            TransformerFactory factory = TransformerFactory.newInstance();
            Transformer transformer = factory.newTransformer(new StreamSource(xsltfile));

            // Set the value of a <param> in the stylesheet
            transformer.setParameter("versionParam", "2.0");

            // Resulting SAX events (the generated FO) must be piped through to FOP
            Result res = new SAXResult(fop.getDefaultHandler());

            // Start XSLT transformation and FOP processing
            transformer.transform(src, res);
        } finally {
            out.close();
        }

    }

    public static void main(String[] args) {
        try {
            System.out.println("FOP ExampleXML2PDF\n");
            System.out.println("Preparing...");

            System.out.println("Input XML: " + args[0]);
            System.out.println("Transformer: " + args[1]);
            System.out.println("Output PDF: " + args[2]);
            if (args[3] != null)
                System.out.println("Config File: " + args[3]);
            System.out.println("Transforming...");

            XML2PDF xp = null;
            if (args[3] != null) {
                xp = new XML2PDF(args[3]);
            } else {
                xp = new XML2PDF();
            }
            xp.transform(args[0],args[1],args[2]);

            System.out.println("Success!");
        } catch (Exception e) {
            e.printStackTrace(System.err);
            System.exit(-1);
        }
    }
}
