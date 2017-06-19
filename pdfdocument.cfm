<cfparam name="attributes.browser_file_name" default="">
<cfparam name="attributes.file_name" default="">

<cfif thistag.executionmode eq "start">
  <cfif not thistag.hasendtag><cfthrow message="cf_document requires an end  Tag."></cfif>
  <cfobject component="cfc_report" name="request.obj_report">
  <cfset request.obj_report.init()>
<cfelse>

  <cfif isdefined("url.print_debug")>
    <cfset attributes.print_debug=url.print_debug>
  </cfif>

  <cfparam name="attributes.print_html" default="false">
  <cfparam name="attributes.print_debug" default="false">
  <cfset request.obj_report.set_raw_content(trim(thistag.generatedcontent))>
  <cfset request.obj_report.set_parse_toc(true)>
  <cfset request.obj_report.set_title_numbering(true)>
  <cfif attributes.print_debug>
    <!--- <cfoutput><div style="border: 1px solid; background-color:##ffffe0; position: absolute;"><pre>#HTMLCodeFormat(thistag.generatedcontent)#</pre></div></cfoutput> --->
    <cfset request.obj_report.print_debug()>
  <cfelseif attributes.print_html>
    <cfset request.obj_report.print_html()>
  <cfelse>
    <cfif attributes.browser_file_name gt "">
      <cfset request.obj_report.set_browser_filename(attributes.browser_file_name)>
    </cfif>
    <cfif attributes.file_name gt "">
      <cfset request.obj_report.print(attributes.file_name,false)>
    <cfelse>
      <cfset request.obj_report.print()>
    </cfif>
  </cfif>
  <cfset thistag.generatedcontent="">
</cfif>