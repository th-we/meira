# meira
##An MEI-to-SVG renderer using only XSLT 2.0

**meira** stands for **MEI rendering application**.  This is a project that was implemented for [Edirom](http://www.edirom.de/) and must be regarded as highly experimental. No further development on this project is intended for reasons outlined in the Results section below.

##Motivation
At the time development started, the options available for rendering MEI were very limited. XSLT was picked for the following reasons:

* MEI and SVG are both XML formats, XSLT is meant to transform one XML into another - looks like a natural choice.
* XSLT is a well established technology in the MEI community.
* I didn't know anything about XSLT when I started this project.

##Results

* I developed some profound XSLT skills by jumping in at the deep end.
* It *is* possible to render music with XSLT.
* It is extremely slow.
* To take the project to a decent level of quality and completeness, processing time would still increase by some order of magnitude.
* XSLT isn't suitable for this kind of task.

##How to try

Use an XSLT 2.0 processor, e.g. [Saxon](http://www.saxonica.com/download/opensource.xml).  Move to the `meira` folder and run the following:

    java -classpath path/to/saxonb.jar net.sf.saxon.Transform Beispiele/Chopin_Mazurka.mei mei2svg.xsl > musx2svg/mazurka.svg
    
Replace `path/to/saxonb.jar` with the proper path to the Saxon B jar file on your system.  Don't try rendering `meira/Beispiele/Weber-op34-A.xml`. It will take your computer an extremely long time to find out the latest revision of meira has a bug that prevents it from rendering.
