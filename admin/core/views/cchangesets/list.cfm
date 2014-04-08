<!--- This file is part of Mura CMS.

Mura CMS is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, Version 2 of the License.

Mura CMS is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with Mura CMS. If not, see <http://www.gnu.org/licenses/>.

Linking Mura CMS statically or dynamically with other modules constitutes the preparation of a derivative work based on 
Mura CMS. Thus, the terms and conditions of the GNU General Public License version 2 ("GPL") cover the entire combined work.

However, as a special exception, the copyright holders of Mura CMS grant you permission to combine Mura CMS with programs
or libraries that are released under the GNU Lesser General Public License version 2.1.

In addition, as a special exception, the copyright holders of Mura CMS grant you permission to combine Mura CMS with 
independent software modules (plugins, themes and bundles), and to distribute these plugins, themes and bundles without 
Mura CMS under the license of your choice, provided that you follow these specific guidelines: 

Your custom code 

• Must not alter any default objects in the Mura CMS database and
• May not alter the default display of the Mura CMS logo within Mura CMS and
• Must not alter any files in the following directories.

 /admin/
 /tasks/
 /config/
 /requirements/mura/
 /Application.cfc
 /index.cfm
 /MuraProxy.cfc

You may copy and distribute Mura CMS with a plug-in, theme or bundle that meets the above guidelines as a combined work 
under the terms of GPL for Mura CMS, provided that you include the source code of that other code when and as the GNU GPL 
requires distribution of source code.

For clarity, if you create a modified version of Mura CMS, you are not obligated to grant this special exception for your 
modified version; it is your choice whether to do so, or to make such modified version available under the GNU General Public License 
version 2 without this exception.  You may, if you choose, apply this exception to your own modified versions of Mura CMS.
--->
<cfoutput>
<!---
<form class="form-inline" novalidate="novalidate" id="changesetSearch" name="changesetSearch" method="get">
	<div class="input-append">
	<input name="keywords" value="#HTMLEditFormat(rc.keywords)#" type="text" class="text" maxlength="50" />
	<button type="button" class="btn" onclick="submitForm(document.forms.changesetSearch);"><i class="icon-search"></i></button>
	<input type="hidden" name="muraAction" value="cChangesets.list">
	<input type="hidden" name="siteid" value="#HTMLEditFormat(rc.siteid)#">
	</div>
</form>
--->

<h1>#application.rbFactory.getKeyValue(session.rb,"changesets")#</h1>

<cfinclude template="dsp_secondary_menu.cfm">

<form novalidate="novalidate" name="searchFrm" onsubmit="return validate(this);" class="fieldset-wrap">
<div class="fieldset">
	<div class="control-group">
		<div class="span2">
		<label class="control-label">#application.rbFactory.getKeyValue(session.rb,"params.from")#</label>
	      <div class="controls">
			<input type="text" class="datepicker span12" name="startDate" value="#LSDateFormat(rc.startDate,session.dateKeyFormat)#" validate="date" message="The 'From' date is required." />
	     </div>
	</div>
	
		<div class="span2">
		<label class="control-label">#application.rbFactory.getKeyValue(session.rb,"params.to")#</label>
	      <div class="controls">
			<input type="text" class="datepicker span12" name="stopDate" value="#LSDateFormat(rc.stopDate,session.dateKeyFormat)#" validate="date" message="The 'To' date is required." />
	     </div>
	</div>
	 
		<div class="span2">
		<label class="control-label">#application.rbFactory.getKeyValue(session.rb,"params.keywords")#</label>
	      <div class="controls">
	      		<input name="keywords" value="#HTMLEditFormat(rc.keywords)#" type="text" class="text" maxlength="50" />
		</div>
	</div>
	</div>
	<cfif application.categoryManager.getCategoryCount(rc.siteid)>
	<div class="control-group">
	    <!--- Category Filters --->
	    <label class="control-label">
	    	<!---#application.rbFactory.getKeyValue(session.rb,'collections.categoryfilters')#--->
	    	Available Categories
	   	</label>
	    <div id="mura-list-tree" class="controls">
	      <cf_dsp_categories_nest siteID="#rc.siteID#" parentID="" nestLevel="0" categoryid="#rc.categoryid#">
	    </div>
	</div>
	</cfif>
</div>
<div class="form-actions">
	<input type="button" class="btn" onclick="submitForm(document.forms.searchFrm);" value="#application.rbFactory.getKeyValue(session.rb,"params.search")#" /></dd>
</div>

<input type="hidden" value="#HTMLEditFormat(rc.siteid)#" name="siteID"/>
<input type="hidden" name="muraAction" value="cChangesets.list">
</form>


<table class="mura-table-grid"> 
<tr>
<th class="var-width">#application.rbFactory.getKeyValue(session.rb,'changesets.name')#</th>
<th>#application.rbFactory.getKeyValue(session.rb,'changesets.datetopublish')#</th>
<th>#application.rbFactory.getKeyValue(session.rb,'changesets.lastupdate')#</th>
<th>&nbsp;</th>
</tr>
<cfif rc.changesets.hasNext()>
<cfloop condition="rc.changesets.hasNext()">
<cfset rc.changeset=rc.changesets.next()>
<tr>
	<td class="var-width"><a title="Edit" href="./?muraAction=cChangesets.assignments&changesetID=#rc.changeset.getchangesetID()#&siteid=#URLEncodedFormat(rc.siteID)#&categoryid=#URLEncodedFormat(rc.categoryid)#">#HTMLEditFormat(rc.changeset.getName())#</a></td>
	<td><cfif isDate(rc.changeset.getPublishDate())>#LSDateFormat(rc.changeset.getPublishDate(),session.dateKeyFormat)# #LSTimeFormat(rc.changeset.getPublishDate(),"medium")#<cfelse>NA</cfif></td>
	<td>#LSDateFormat(rc.changeset.getLastUpdate(),session.dateKeyFormat)# #LSTimeFormat(rc.changeset.getLastUpdate(),"medium")#</td>
	<td class="actions">
		<ul>
			<li class="edit"><a title="#application.rbFactory.getKeyValue(session.rb,'changesets.edit')#" href="./?muraAction=cChangesets.edit&changesetID=#rc.changeset.getchangesetID()#&siteid=#URLEncodedFormat(rc.changeset.getSiteID())#&categoryid=#URLEncodedFormat(rc.categoryid)#"><i class="icon-pencil"></i></a></li>
			<cfif rc.changeset.getPublished()>
				<li class="preview disabled"><i class="icon-globe"></i></li>
			<cfelse>
				<li class="preview"><a title="#application.rbFactory.getKeyValue(session.rb,'changesets.preview')#" href="##" onclick="return preview('http://#application.settingsManager.getSite(rc.siteid).getDomain()##application.configBean.getServerPort()##application.configBean.getContext()##$.getURLStem(rc.siteid,"")#?changesetID=#JSStringFormat(rc.changeset.getChangesetID())#','');"><i class="icon-globe"></i></a></li>
			</cfif>
			<li class="change-sets"><a title="#application.rbFactory.getKeyValue(session.rb,'changesets.assignments')#" href="./?muraAction=cChangesets.assignments&changesetID=#rc.changeset.getchangesetID()#&siteid=#URLEncodedFormat(rc.changeset.getSiteID())#&categoryid=#URLEncodedFormat(rc.categoryid)#"><i class="icon-reorder"></i></a></li>
			<li class="delete"><a title="#application.rbFactory.getKeyValue(session.rb,'changesets.delete')#" href="./?muraAction=cChangesets.delete&changesetID=#rc.changeset.getchangesetID()#&siteid=#URLEncodedFormat(rc.changeset.getSiteID())#&categoryid=#URLEncodedFormat(rc.categoryid)#" onclick="return confirmDialog('#jsStringFormat(application.rbFactory.getKeyValue(session.rb,'changesets.deleteconfirm'))#',this.href)"><i class="icon-remove-sign"></i></a></li>
		</ul>
	</td>
</tr></cfloop>
<cfelse>
<tr>
<td class="noResults" colspan="4">#application.rbFactory.getKeyValue(session.rb,'changesets.nochangesets')#</td>
</tr>
</cfif>
</table>

<cfif rc.changesets.pageCount() gt 1>
	<cfset args=arrayNew(1)>
	<cfset args[1]="#rc.changesets.getFirstRecordOnPageIndex()#-#rc.changesets.getLastRecordOnPageIndex()#">
	<cfset args[2]=rc.changesets.getRecordcount()>
	<div class="clearfix mura-results-wrapper">
		<p class="search-showing">
			#application.rbFactory.getResourceBundle(session.rb).messageFormat(application.rbFactory.getKeyValue(session.rb,"sitemanager.paginationmeta"),args)#
		</p>
		<div class="pagination">
		<ul class="moreResults">
		<cfif rc.changesets.getPageIndex() gt 1>
		<li>
			<a href="./?muraAction=cChangesets.list&page=#evaluate('#rc.changesets.getPageIndex()#-1')#&siteid=#URLEncodedFormat(rc.siteid)#&keywords=#URLEncodedFormat(rc.keywords)#&startdate=#URLEncodedFormat(rc.startdate)#&stopdate=#URLEncodedFormat(rc.stopdate)#&categoryid=#URLEncodedFormat(rc.categoryid)#">&laquo;&nbsp;#application.rbFactory.getKeyValue(session.rb,'user.prev')#</a>
		</li>
		</cfif>
		<cfloop from="1"  to="#rc.changesets.pageCount()#" index="i">
			<cfif rc.changesets.getPageIndex() eq i> 
				<li class="active"><a href="##">#i#</a></li>
			<cfelse> 
				<li>
					<a href="./?muraAction=cChangesets.list&page=#i#&siteid=#URLEncodedFormat(rc.siteid)#keywords=#URLEncodedFormat(rc.keywords)#&startdate=#URLEncodedFormat(rc.startdate)#&stopdate=#URLEncodedFormat(rc.stopdate)#&categoryid=#URLEncodedFormat(rc.categoryid)#">#i#</a>
				</li>
			</cfif>
		</cfloop>
		<cfif rc.changesets.getPageIndex() lt rc.changesets.pagecount()>
			<li>
				<a href="./?muraAction=cChangesets.list&page=#evaluate('#rc.changesets.getPageIndex()#+1')#&siteid=#URLEncodedFormat(rc.siteid)#&keywords=#URLEncodedFormat(rc.keywords)#&startdate=#URLEncodedFormat(rc.startdate)#&stopdate=#URLEncodedFormat(rc.stopdate)#&categoryid=#URLEncodedFormat(rc.categoryid)#">&laquo;&nbsp;#application.rbFactory.getKeyValue(session.rb,'user.next')#</a>
			</li>
		</cfif>
		</ul>
		</div>
	</div>
</cfif>
</cfoutput>