<#macro paginate currentPage totalPage actionUrl urlParas="" className="">
  <#if actionUrl?? && !actionUrl?ends_with("/")><#local actionUrl = actionUrl+"/"></#if>
  <#if urlParas?? && urlParas?trim !=""><#local urlParas = "?"+urlParas></#if>
  <#if (totalPage <= 0) || (currentPage > totalPage)><#return></#if>
  <#local startPage = currentPage - 2>
  <#if (startPage < 1)><#local startPage = 1></#if>

  <#local endPage = currentPage + 2>
  <#if (endPage > totalPage)><#local endPage = totalPage></#if>

<ul class="${className}">
  <#if (currentPage <= 5)>
    <#local startPage = 1>
  </#if>
  <#if ((totalPage - currentPage) < 5)>
    <#local endPage = totalPage>
  </#if>

  <#if (currentPage == 1)>
    <li class="disabled"><span class="prev_page"><<</span></li>
  <#else>
    <li><a href="${actionUrl}#{currentPage - 1}${urlParas!}" class="prev_page"><<</a></li>
  </#if>

  <#if (currentPage > 5)>
    <li><a href="${actionUrl}#{1}${urlParas!}">#{1}</a></li>
    <li><a href="${actionUrl}#{2}${urlParas!}">#{2}</a></li>
    <li><a href="javascript:void(0);">…</a></li>
  </#if>

  <#list startPage..endPage as i>
    <#if currentPage == i>
      <li class="active"><a href="javascript:void(0);">#{i}<span class="sr-only">(current)</span></a></li>
    <#else>
      <li><a href="${actionUrl}#{i}${urlParas!}">#{i}</a></li>
    </#if>
  </#list>

  <#if ((totalPage - currentPage) >= 5)>
    <li><a href="javascript:void(0);">…</a></li>
    <li><a href="${actionUrl}#{totalPage - 1}${urlParas!}">#{totalPage - 1}</a></li>
    <li><a href="${actionUrl}#{totalPage}${urlParas!}">#{totalPage}</a></li>
  </#if>

  <#if (currentPage == totalPage)>
    <li class="disabled"><span class="next_page">>></span></li>
  <#else>
    <li><a href="${actionUrl}#{currentPage + 1}${urlParas!}" class="next_page" rel="next">>></a></li>
  </#if>
</ul>
</#macro>