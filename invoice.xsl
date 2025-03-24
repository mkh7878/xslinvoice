<xsl:stylesheet version="1.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:fo="http://www.w3.org/1999/XSL/Format">


    <xsl:output method="xml" indent="yes"/>

    <xsl:template match="/">
        <fo:root>
            <fo:layout-master-set>
                <!-- Define page layout -->
                <fo:simple-page-master master-name="A4"
                    page-width="8.5in" page-height="11in"
                    margin="1in">
                    <fo:region-body margin="0in"/>
                </fo:simple-page-master>
            </fo:layout-master-set>

            <fo:page-sequence master-reference="A4">
    
                <fo:flow flow-name="xsl-region-body">
                    <fo:block-container 
                        position="absolute"
                        top="0pt" left="0pt"
                        padding="100pt"
                        width="100%" height="100%"> 

                        <!-- Invoice Header -->
                        <fo:table table-layout="fixed" width="100%">
                            <fo:table-column column-width="15%"/>
                            <fo:table-column column-width="60%"/>
                            <fo:table-column column-width="25%"/>
                            
                            <fo:table-body>
                                <fo:table-row>
                                    <!-- Logo Cell -->
                                    <fo:table-cell>
                                        <fo:block>
                                            <fo:external-graphic src="url('cat.png')" content-width="60px" height="auto"/>
                                        </fo:block>
                                    </fo:table-cell>
                                    <!-- Company -->
                                    <fo:table-cell>
                                        <fo:block font-size="30pt" font-weight="bold" text-align="left" color="#486140" padding-top="20pt">
                                            Cat Food Corp.
                                        </fo:block>
                                    </fo:table-cell>
                                    <!-- Invoice Number -->
                                    <fo:table-cell>
                                    <fo:block padding-top="20pt" text-align="right">
                                    Invoice # <xsl:value-of select="invoice/invoiceno"/>
                                    </fo:block>                                    
                                    </fo:table-cell>
                                </fo:table-row>
                            </fo:table-body>
                        </fo:table>

                        <fo:table table-layout="fixed" width="100%">
                            <fo:table-column column-width="60%"/>
                            <fo:table-column column-width="20%"/>
                            <fo:table-column column-width="20%"/>
                            
                            <fo:table-body>
                                <fo:table-row>
                                    <!-- Address -->
                                    <fo:table-cell  padding-top="50pt">
                                        <fo:block >
                                    <!-- Customer Info -->
                                    <fo:block font-size="12pt" font-weight="bold" space-before="10pt">
                                        Bill To:
                                    </fo:block>
                                    <fo:block font-size="12pt">
                                        <xsl:value-of select="invoice/customer/name"/>
                                    </fo:block>
                                    <fo:block font-size="12pt">
                                        <xsl:value-of select="invoice/customer/address"/>
                                    </fo:block>
                                        </fo:block>
                                    </fo:table-cell>
                                    <!-- Issue Date & Due Date -->
                                    <fo:table-cell  padding-top="50pt">
                                        <fo:block font-size="12pt" text-align="left">
                                            <fo:inline font-weight="bold">Company: </fo:inline> 
                                        </fo:block>
                                        <fo:block font-size="12pt" text-align="left">
                                            <fo:inline font-weight="bold">Date: </fo:inline> 
                                        </fo:block>
                                    </fo:table-cell>
                                     <fo:table-cell  padding-top="50pt">
                                        <fo:block font-size="12pt" text-align="right">
                                             <xsl:value-of select="invoice/company"/>
                                        </fo:block>
                                        <fo:block font-size="12pt" text-align="right">
                                            <xsl:value-of select="invoice/date"/>
                                        </fo:block>
                                    </fo:table-cell>
                                </fo:table-row>
                            </fo:table-body>
                        </fo:table>

        


                        <!-- Items Table -->
                        <fo:block font-size="14pt" font-weight="bold" space-before="40pt">
                            Items:
                        </fo:block>
                        
                        <fo:table border="2pt solid black" width="100%" space-before="10pt" margin="30pt">
                            <fo:table-column column-width="40%"/>
                            <fo:table-column column-width="25%"/>
                            <fo:table-column column-width="25%"/>
                            <fo:table-header>
                                <fo:table-row>
                                    <fo:table-cell background-color="#95ae8d" border-bottom="2pt solid black">
                                        <fo:block font-weight="bold" padding-top="10pt" padding-bottom="10pt" text-align="center">
                                            Description
                                        </fo:block>
                                    </fo:table-cell>
                                    <fo:table-cell background-color="#678160" border-bottom="2pt solid black">
                                        <fo:block font-weight="bold" padding-top="10pt" color="white" padding-bottom="10pt" text-align="center">
                                            Quantity
                                        </fo:block>
                                    </fo:table-cell>
                                    <fo:table-cell background-color="#43513f" border-bottom="2pt solid black">
                                        <fo:block font-weight="bold" padding-top="10pt" padding-bottom="10pt" color="white" text-align="center">
                                            Price
                                        </fo:block>
                                    </fo:table-cell>
                                </fo:table-row>
                        </fo:table-header>

                            <fo:table-body>
                                <xsl:for-each select="invoice/items/item">
                                    <fo:table-row space-after="10pt">
                                        <fo:table-cell>
                                            <fo:block padding-bottom="10pt" padding-top="20pt"><xsl:value-of select="description"/></fo:block>
                                        </fo:table-cell>
                                        <fo:table-cell>
                                            <fo:block padding-bottom="10pt" padding-top="20pt"><xsl:value-of select="quantity"/></fo:block>
                                        </fo:table-cell>
                                        <fo:table-cell>
                                            <fo:block padding-bottom="10pt" padding-top="20pt">$<xsl:value-of select="price"/></fo:block>
                                        </fo:table-cell>
                                    </fo:table-row>
                                </xsl:for-each>
                            </fo:table-body>
                        </fo:table>

                        <!-- Total -->
                        <fo:block font-size="14pt" font-weight="bold" space-before="10pt" text-align="right">
                            Total: $<xsl:value-of select="invoice/total"/>
                        </fo:block>

                        <fo:block font-size="14pt" font-weight="bold" space-before="10pt" text-align="right">
                            Issued By:
                        </fo:block>

                        <fo:block space-before="10pt" text-align="right">
                            <fo:external-graphic src="url('print.png')" content-width="60px" height="auto"/>
                        </fo:block>

                        <fo:block font-size="12pt" space-before="5pt" text-align="right">
                            CEO, Cat Food Corp.
                        </fo:block>



                    </fo:block-container>
                </fo:flow>
            </fo:page-sequence>
        </fo:root>
    </xsl:template>

</xsl:stylesheet>
