{**
* 2007-2016 PrestaShop
*
* NOTICE OF LICENSE
*
* This source file is subject to the Open Software License (OSL 3.0)
* that is bundled with this package in the file LICENSE.txt.
* It is also available through the world-wide-web at this URL:
* http://opensource.org/licenses/osl-3.0.php
* If you did not receive a copy of the license and are unable to
* obtain it through the world-wide-web, please send an email
* to license@buy-addons.com so we can send you a copy immediately.
*
* DISCLAIMER
*
* Do not edit or add to this file if you wish to upgrade PrestaShop to newer
* versions in the future. If you wish to customize PrestaShop for your
* needs please refer to http://www.prestashop.com for more information.
*
*  @author Buy-Addons <hatt@buy-addons.com>
*  @copyright  2007-2016 PrestaShop SA
*  @license    http://opensource.org/licenses/osl-3.0.php  Open Software License (OSL 3.0)
*  International Registered Trademark & Property of PrestaShop SA
*}
<form id="configuration_form" class="defaultForm  form-horizontal"  method="post" enctype="multipart/form-data">
<div class="panel" id="fieldset_0">
    <h3>{l s='Unlimited Product Tab' mod='unlimitedproducttab'}</h3>
        <div class="form-group showtitle" style="display:{if $rowtype == "tag" || $rowtype =="description" || $rowtype =="review" || $rowtype == "datasheet"}none{else}block{/if};">
            <label for="tab_title" class="control-label col-lg-3 required">{l s='Tab Title:' mod='unlimitedproducttab'}</label>
            <div class="col-lg-9 " style="width: 50%;">
			{assign var=arr_lang value=$rowtitle|json_decode:1}
                <div class="lang {$iso_default_language|escape:'htmlall':'UTF-8'}" data-iso-default="{$iso_default_language|escape:'htmlall':'UTF-8'}">
                   {foreach from=$arr_lang key=key_lang item=language}
                        <div class="language_{$key_lang|escape:'htmlall':'UTF-8'} iso_code" data-iso="{$key_lang|escape:'htmlall':'UTF-8'}" style="display:{if $iso_default_language == $key_lang}block;{else}none;{/if}" >
                            <input type="text" name="tab_title_{$key_lang|escape:'htmlall':'UTF-8'}" id="tab_title_{$key_lang|escape:'htmlall':'UTF-8'}" value="{$language|escape:'htmlall':'UTF-8'}" style="width:100%;">
                        </div>
                   {/foreach}
                </div>
            </div>
            <div class="col-lg-2">
                <div  class="col-lg-1">
                    <button type="button" class="btn btn-default dropdown-toggle language_view iso_code_now" data-toggle="dropdown" tabindex="-1" data-iso-choose="{$iso_default_language|escape:'htmlall':'UTF-8'}">
                        {$iso_default_language|escape:'htmlall':'UTF-8'}
                        <span class="caret"></span>
                    </button><ul class="dropdown-menu">
                        {foreach from=$arr_language key=key_lang item=language}
                            <li>
                                <a  href="javascript:void(0);" onclick="baHideOtherLanguage('{$language.id_lang|escape:'htmlall':'UTF-8'}','{$language.iso_code|escape:'htmlall':'UTF-8'}')">{$language.name|escape:'htmlall':'UTF-8'}</a>
                            </li>
                        {/foreach}
                    </ul>
                </div>
            </div>
        </div>
        {*assign var=foo value=","|explode:$size*}
        {assign var=foo value=$size|json_decode:1}
        
        <div class="form-group ">
            <label  class="control-label col-lg-3 ">{l s='Type:' mod='unlimitedproducttab'}</label>
            <div class="col-lg-9">
                <select onchange="changetype(this.value)" style="width:100px; float:left;" name="selecttype" class="selecttype">
                    <option value="editor" {if $rowtype == 'editor'}selected="selected"{/if}>{l s='Editor' mod='unlimitedproducttab'}</option>
                    <option value="youtube" {if $rowtype == 'youtube'}selected="selected"{/if} >{l s='Youtube' mod='unlimitedproducttab'}</option>
                    <option value="maps" {if $rowtype == 'maps'}selected="selected"{/if}>{l s='Google Maps' mod='unlimitedproducttab'}</option>
                    <option value="vimeo" {if $rowtype == 'vimeo'}selected="selected"{/if}>{l s='Vimeo' mod='unlimitedproducttab'}</option>
                    <option value="tag" {if $rowtype == 'tag'}selected="selected"{/if}>{l s='Product Tag' mod='unlimitedproducttab'}</option>
                    <option value="description" {if $rowtype == 'description'}selected="selected"{/if}>{l s='Product Description' mod='unlimitedproducttab'}</option>
                    <option value="datasheet" {if $rowtype == 'datasheet'}selected="selected"{/if}>{l s='Product Datasheet' mod='unlimitedproducttab'}</option>
                    <option value="review" {if $rowtype == 'review'}selected="selected"{/if}>{l s='Product Review' mod='unlimitedproducttab'}</option>
                    <option value="product" {if $rowtype == 'product'}selected="selected"{/if}>{l s='Product' mod='unlimitedproducttab'}</option>
                </select>
            </div>
        </div>
        <div class="form-group">
            <label class="control-label col-lg-3 required">{l s='Tab Position:' mod='unlimitedproducttab'}</label>
            <div class="col-lg-9">
                <input type="text" name="tabposition" id="tabposition" value="{$tabposition|escape:'htmlall':'UTF-8'}"  style="width:105px;">
            </div>
            {*<label class="control-label col-lg-3 ">{l s=' ' mod='unlimitedproducttab'}</label>
            <div class="col-lg-9 " style = "float: left;"><p class="help-block">{l s='Input tab position' mod='unlimitedproducttab'}</p></div>*}
        </div>
        
        <div class="form-group " >      
            <label class="control-label col-lg-3">{l s='Status' mod='unlimitedproducttab'}: </label>
            <div  class="col-lg-9 input-group col-lg-3">
                <span class="switch prestashop-switch fixed-width-lg">
                    <input type="radio" name="active" id="active_on" value="1" {if $status == 1}checked="checked"{/if} >
                    <label for="active_on"  class="radioCheck">
                        {*<i class="icon-check-sign text-success"></i>*}
                        Yes
                    </label>
                    <input type="radio" name="active" id="active_off" value="0" {if $status == 0}checked="checked"{/if}>
                    <label for="active_off" class="radioCheck">
                        {*<i class="icon-ban-circle text-danger"></i>*}
                        No
                    </label>
                    <a class="slide-button btn btn-default"></a>
                </span>
            </div>
        </div>
        
        <div class="form-group showtitle" style="display:{if $rowtype == "tag" || $rowtype =="description" || $rowtype =="review" || $rowtype == "datasheet"}none{else}block{/if};">                                    
            <label  class="control-label col-lg-3 ">{l s='Using' mod='unlimitedproducttab'}</label>
            <div class="col-lg-9">
                <div class="radio" style = "width:750px;float: left;">
                    <label><input onclick="showeditor()" type="radio" name="choose_using" id="active_on" {if $check_using_tab == "all-product"}checked="checked"{/if}  value="all-product">{l s='All products' mod='unlimitedproducttab'}</label>
                </div>
                <div class="radio" style = "width:750px;float: left;">
                    <label><input onclick="hideeditor()" type="radio" name="choose_using" id="active_on" {if $check_using_tab == 'config-tab'}checked="checked"{/if}  value='config-tab'>{l s='Config products' mod='unlimitedproducttab'}</label>
                </div>
            </div>
        </div>      
        
        {if $rowtype == 'editor'}
            {assign var=arr_lang value=$content|json_decode:1}
            <div class="form-group display showeditortype ">
                <label class="control-label col-lg-3 ">{l s='Content' mod='unlimitedproducttab'}</label>
                <div class="col-lg-9 " style="width: 50%;">
					<div class="lang {$iso_default_language|escape:'htmlall':'UTF-8'}" data-iso-default="{$iso_default_language|escape:'htmlall':'UTF-8'}">
						{foreach from = $arr_lang key=key_lang_content item=content_lang}
						{*$content_lang|var_dump*}
							<div class="language_{$key_lang_content|escape:'htmlall':'UTF-8'} iso_code" data-iso="{$key_lang_content|escape:'htmlall':'UTF-8'}" style="display:{if $iso_default_language == $key_lang_content}block;{else}none;{/if}" >
								 <textarea id="editor_pdf_{$key_lang_content|escape:'htmlall':'UTF-8'}" class="rte" name="editor_pdf_{$key_lang_content|escape:'htmlall':'UTF-8'}">
									{$content_lang|escape:'htmlall':'UTF-8'}
								 </textarea>
							</div>
						{/foreach}
					</div>
                </div>
                
                <div class="col-lg-2">
					<div class="col-lg-1">
						<button type="button" class="btn btn-default dropdown-toggle language_view iso_code_now" data-toggle="dropdown" tabindex="-1" data-iso-choose="{$iso_default_language|escape:'htmlall':'UTF-8'}">
							{$iso_default_language|escape:'htmlall':'UTF-8'}
							<span class="caret"></span>
						</button><ul class="dropdown-menu">
							{foreach from=$arr_language key=key_lang item=language}
								<li>
									<a  href="javascript:void(0);" onclick="baHideOtherLanguage('{$language.id_lang|escape:'htmlall':'UTF-8'}','{$language.iso_code|escape:'htmlall':'UTF-8'}')">{$language.name|escape:'htmlall':'UTF-8'}</a>
								</li>
							{/foreach}
						</ul>
					</div>
				</div>
            </div>
        {else}
            <div class="form-group display showeditortype" style= "display:none;">
                <label class="control-label col-lg-3 ">{l s='Content' mod='unlimitedproducttab'}:</label>
                <div class="col-lg-9 " style="width: 50%;">
                    {*<textarea style="width:100%;"cols="10" rows="10" name="texteditor" class="autoload_rte rte"></textarea>*}
                    <div class="lang {$iso_default_language|escape:'htmlall':'UTF-8'}" data-iso-default="{$iso_default_language|escape:'htmlall':'UTF-8'}">
                       {foreach from=$arr_language key =key_lang item=language}
                            <div class="language_{$language.iso_code|escape:'htmlall':'UTF-8'} iso_code" data-iso="{$language.iso_code|escape:'htmlall':'UTF-8'}" style="{if $id_default_language == $language.id_lang}display:block;{/if} {if $id_default_language != $language.id_lang}display:none;{/if}" >
                                 <textarea id="editor_pdf_{$language.iso_code|escape:'htmlall':'UTF-8'}" class="rte" name="editor_pdf_{$language.iso_code|escape:'htmlall':'UTF-8'}">
                                 </textarea>
                            </div>
                       {/foreach}
                    </div>
                </div>
                <div class="col-lg-2">
					<div class="col-lg-1">
						<button type="button" class="btn btn-default dropdown-toggle language_view iso_code_now" data-toggle="dropdown" tabindex="-1" data-iso-choose="{$iso_default_language|escape:'htmlall':'UTF-8'}">
							{$iso_default_language|escape:'htmlall':'UTF-8'}
							<span class="caret"></span>
						</button><ul class="dropdown-menu">
							{foreach from=$arr_language key=key_lang item=language}
								<li>
									<a  href="javascript:void(0);" onclick="baHideOtherLanguage('{$language.id_lang|escape:'htmlall':'UTF-8'}','{$language.iso_code|escape:'htmlall':'UTF-8'}')">{$language.name|escape:'htmlall':'UTF-8'}</a>
								</li>
							{/foreach}
						</ul>
					</div>
				</div>
            </div>          
        {/if}
            
        <div class="form-group display  showyoutubetype" style="display:{if ($check_using_tab == 'config-tab') || ($rowtype !='youtube')}none{else}block{/if};">
            <label class="control-label col-lg-3 ">{l s='Link Youtube' mod='unlimitedproducttab'}:</label>
            <div class="col-lg-9">
                <input type="text" name="linkyoutube"  value="{if $rowtype=='youtube'}{$content|escape:'htmlall':'UTF-8'}{/if}" class="linkyoutube" style="width:200px;">
            </div>
            <label class="control-label col-lg-3 ">{l s=' ' mod='unlimitedproducttab'}</label>
            <div class="col-lg-9 " style = "float: right;"><p class="help-block">{l s='Input link youtube' mod='unlimitedproducttab'}</p></div>
        </div>
        <div class="form-group display  showyoutubetype" style="display:{if ($check_using_tab == 'config-tab') || ($rowtype!='youtube')}none{else}block{/if};">
            <label class="control-label col-lg-3 ">{l s='Width:' mod='unlimitedproducttab'}</label>
            <div class="col-lg-9"  style="width:100px;">
                <input type="text" name="widthyoutube" value="{if $size }{$foo['width']|escape:'htmlall':'UTF-8'}{/if}" />
            </div>
			<label class="control-label" ">{l s='px' mod='unlimitedproducttab'}</label>
        </div>
        <div class="form-group display  showyoutubetype" style="display:{if ($check_using_tab == 'config-tab') || ($rowtype!='youtube')}none{else}block{/if};">
            <label class="control-label col-lg-3 ">{l s='Height:' mod='unlimitedproducttab'}</label>
            <div class="col-lg-9" style="width:100px;">
                <input type="text" name="heightyoutube" value="{if $size }{$foo['height']|escape:'htmlall':'UTF-8'}{/if}" />
            </div>
			<label class="control-label" ">{l s='px' mod='unlimitedproducttab'}</label>
        </div>

        <div class="form-group display  showmapstype" style="display:{if ($check_using_tab == 'config-tab') || ($rowtype!='maps')}none{else}block{/if};" >
		{if $rowtype == 'maps'}
	        {assign var=lat_lng  value=$content|json_decode:1}
			{assign var=latlng value=","|implode:$lat_lng}
		{/if}
            <label class="control-label col-lg-3 ">Address : </label> 
            <div class="col-lg-9">
                <input name= "add" value= "{if $rowtype =='maps'}{$latlng|escape:'htmlall':'UTF-8'}{/if}" id="addresspicker_map" />
            </div>
        </div>      
        <div class="form-group display  showmapstype"  style="display:{if ($check_using_tab == 'config-tab') || ($rowtype!='maps')}none{else}block{/if};" >
            <label class="control-label col-lg-3 ">{l s=' ' mod='unlimitedproducttab'}</label>
            <div class="col-lg-9" >
                <div class="map-responsive">
                    <div  id="map" style="width:450px;height:270px;border: 1px solid #DDD;"></div>
                </div>
            </div>
            <label class="control-label col-lg-3 ">{l s=' ' mod='unlimitedproducttab'}</label>      
            <div class="col-lg-9 " style = "float: left;">
                <p class="help-block">{l s='You can drag and drop the marker to the correct location' mod='unlimitedproducttab'}</p>
            </div>
        </div>
        
        <div class="form-group display  showmapstype"  style="display:{if ($check_using_tab == 'config-tab') || ($rowtype!='maps')}none{else}block{/if};" >
            <label class="control-label col-lg-3 ">{l s='Width:' mod='unlimitedproducttab'}</label>
            <div class="col-lg-9"  style="width:100px;">
                <input type="text" name="widthmaps" value="{if $size }{$foo['width']|escape:'htmlall':'UTF-8'}{/if}" />
            </div>
			<label class="control-label" ">{l s='px' mod='unlimitedproducttab'}</label>
        </div>
        
        <div class="form-group display  showmapstype"  style="display:{if ($check_using_tab == 'config-tab') || ($rowtype!='maps')}none{else}block{/if};" >
            <label class="control-label col-lg-3 ">{l s='Height:' mod='unlimitedproducttab'}</label>
            <div class="col-lg-9" style="width:100px;">
                <input type="text" name="heightmaps" value="{if $size }{$foo['height']|escape:'htmlall':'UTF-8'}{/if}" />
            </div>
			<label class="control-label" ">{l s='px' mod='unlimitedproducttab'}</label>
        </div>
        
        <div class="form-group display "  style="display:none;" >
            <label  class="control-label col-lg-3 ">Lat:</label>
            <div class="col-lg-9"><input name = "lat" value=""  id="lat" /></div> <br/>
        </div>
        <div class="form-group display " style="display:none;" >
            <label  class="control-label col-lg-3 ">Lng:</label>
            <div class="col-lg-9"><input name = "lng" value = "" id="lng" /></div>
        </div>
    
        <div class="form-group display  showvimeotype" style="display:{if ($check_using_tab == 'config-tab') || ($rowtype!='vimeo')}none{else}block{/if};" >
            <label class="control-label col-lg-3 ">{l s='Link Vimeo' mod='unlimitedproducttab'}:</label>
            <div class="col-lg-9">
                <textarea name="linkvimeo"  style="width:100%;">{if $rowtype =="vimeo"}{$content|escape:'htmlall':'UTF-8'}{/if}</textarea>
            </div>
        </div>  
        <div class="form-group display  showvimeotype"  style="display:{if ($check_using_tab == 'config-tab') || ($rowtype!='vimeo')}none{else}block{/if};" >
            <label class="control-label col-lg-3 ">{l s='Width:' mod='unlimitedproducttab'}</label>
            <div class="col-lg-9"  style="width:100px;">
                <input type="text" name="widthvimeo" value="{if $size }{$foo['width']|escape:'htmlall':'UTF-8'}{/if}" />
            </div>
			<label class="control-label" ">{l s='px' mod='unlimitedproducttab'}</label>
        </div>
        
        <div class="form-group display  showvimeotype" style="display:{if ($check_using_tab == 'config-tab') || ($rowtype!='vimeo')}none{else}block{/if};" >
            <label class="control-label col-lg-3 ">{l s='Height:' mod='unlimitedproducttab'}</label>
            <div class="col-lg-9" style="width:100px;">
                <input type="text" name="heightvimeo" value="{if $size }{$foo['height']|escape:'htmlall':'UTF-8'}{/if}" />
            </div>
			<label class="control-label" ">{l s='px' mod='unlimitedproducttab'}</label>
        </div>
		{assign var=arr value=$content|json_decode:1}
        <div class="showproduct" style="display:{if $rowtype == 'product'}block;{else}none;{/if}">
			<div class="form-group display" >
			<label class="control-label col-lg-3 ">{l s='Show Type' mod='unlimitedproducttab'}</label>
				<div class="col-lg-9" style="width:140px;">
					<select class="selectproduct" name= "selectproduct" onchange="changeproductedit(this.value)">
						<option value="newproduct"{if $rowtype == 'product'}{if $arr[0] == 'newproduct'} selected="selected"{/if} {else}selected="selected"{/if} >{l s='New Product' mod='unlimitedproducttab'}</option>
						<option value="popular" {if $rowtype == 'product'}{if $arr[0] == 'popular'}selected="selected"{/if}{/if} >{l s='Popular' mod='unlimitedproducttab'}</option>
						<option value="bestseller" {if $rowtype == 'product'}{if $arr[0] == 'bestseller'}selected="selected"{/if}{/if} >{l s='Best Sales' mod='unlimitedproducttab'}</option>
						<option value="special" {if $rowtype == 'product'}{if $arr[0] == 'special'}selected="selected"{/if}{/if} >{l s='Special' mod='unlimitedproducttab'}</option>
						<option value="manual" {if $rowtype == 'product'}{if $arr[0] == 'manual'}selected="selected"{/if} {/if}>{l s='Manual' mod='unlimitedproducttab'}</option>
					</select>
				</div>
			</div>
			
			<div class="form-group display hidemanual">
				<label class="control-label col-lg-3 ">{l s='Count' mod='unlimitedproducttab'}</label>
				<div class="col-lg-9" style="width:100px;">
					<input type="text" name="countproduct" value="{if $rowtype == 'product'}{$arr[1]|escape:'htmlall':'UTF-8'}{/if}" />
				</div>
			</div>
			<div class="form-group display  hidemanual" >        
				<label class="control-label col-lg-3">{l s='Same Category:' mod='unlimitedproducttab'} </label>
				<div class="col-lg-9 input-group col-lg-3 ">
					<span class="switch prestashop-switch fixed-width-lg">
						<input type="radio" name="active_product" id="active_on_product" value="1"{if $rowtype == 'product'}{if $arr[2] == '1'} checked= "checked" {/if} {else} checked= "checked" {/if}>
						<label for="active_on_product" class="radioCheck">
							{l s='Yes' mod='unlimitedproducttab'}
						</label>
						<input type="radio" name="active_product" id="active_off_product" value="0" {if $rowtype == 'product'} {if $arr[2] == '0'} checked= "checked"{/if} {/if}>
						<label for="active_off_product" class="radioCheck">
							{l s='No' mod='unlimitedproducttab'}
						</label>
						<a class="slide-button btn btn-default"></a>
					</span>
				</div>
			</div>
			<div class="form-group display  manual">
				<label class="control-label col-lg-3 ">{l s='Id Product' mod='unlimitedproducttab'}</label>
				<div class="col-lg-9" style="width:50%">
					<input type="text" name="manualID" value="{if $rowtype == 'product' && $content|strpos:'manual'}{$arr[3]|escape:'htmlall':'UTF-8'}{/if}" />
				</div>
			</div>
		</div>
        <!-- script -->
        <div class="panel-footer">
        <button type="submit" class="btn btn-default pull-right" name="unlimited-savestay-tab"><i class="process-icon-save"></i>{l s=' Save & Stay' mod='unlimitedproducttab'}</button>
        <button type="submit" class="btn btn-default pull-right" name="unlimited-save-tab"><i class="process-icon-save"></i> {l s=' Save' mod='unlimitedproducttab'}</button>
        <a id="desc-configuration-cancel" class="btn btn-default" href="index.php?controller=AdminModules&amp;configure={$name|escape:'htmlall':'UTF-8'}&amp;cancel&amp;token={$token|escape:'htmlall':'UTF-8'}">
            <i class="process-icon-cancel "></i> <span>{l s=' Cancel' mod='unlimitedproducttab'}</span>
        </a>            
</div>
</div>
</form>
<script type="text/javascript">
function baHideOtherLanguage(id_lang, iso_lang){
    $(".language_view").html(iso_lang+' <span class="caret"></span>');
    $(".lang>div").css("display","none");
    $(".lang>div.language_"+iso_lang).css("display","block");
    $(".iso_code_now").attr("data-iso-choose",iso_lang);
}
</script>
<script type="text/javascript">
$(function() {
    var addresspickerMap = $( "#addresspicker_map" ).addresspicker({
    regionBias: 'fr',
    language: 'fr',
    updateCallback: showCallback,
    mapOptions: {
    zoom: 6,
    center: new google.maps.LatLng({if $rowtype == 'maps'}arr[0],arr[1]{else}46,2{/if}),
    scrollwheel: false,
    mapTypeId: google.maps.MapTypeId.ROADMAP
  },
  elements: {
    map:      '#map',
    lat:      '#lat',
    lng:      '#lng',
    street_number: '#street_number',
    route: '#route',
    locality: '#locality',
    sublocality: '#sublocality',
    administrative_area_level_3: '#administrative_area_level_3',
    administrative_area_level_2: '#administrative_area_level_2',
    administrative_area_level_1: '#administrative_area_level_1',
    country:  '#country',
    postal_code: '#postal_code',
    type:    '#type'
  }
});

var gmarker = addresspickerMap.addresspicker( 'marker');
gmarker.setVisible(true);
addresspickerMap.addresspicker( 'updatePosition');

$('#reverseGeocode').change(function(){
  $('#addresspicker_map').addresspicker('option', 'reverseGeocode', ($(this).val() === 'true'));
});

function showCallback(geocodeResult, parsedGeocodeResult){
  $('#callback_result').text(JSON.stringify(parsedGeocodeResult, null, 4));
}
// Update zoom field
var map = $('#addresspicker_map').addresspicker('map');
google.maps.event.addListener(map, 'idle', function(){
  $('#zoom').val(map.getZoom());
});

});
var lat = $('#addresspicker_map').val();
var arr = lat.split(",");
</script>
<script type="text/javascript">
var checkselected = $('.selecttype').val();
var checkedradio = $('[name="choose_using"]:radio:checked').val();
var val1='';
if(checkedradio =='config-tab'){
    jQuery(".display").hide();
	
}
function hideeditor(){
    jQuery(".display").hide();
    return checkedradio = $('[name="choose_using"]:radio:checked').val();
}
function showeditor(){
    if(val1 == 'editor'){
        jQuery(".show"+val1+"type").show();
        jQuery(".showyoutubetype").hide();
        jQuery(".showmapstype").hide();
        jQuery(".showvimeotype").hide();
		jQuery(".showproduct").hide();
        }
    if(val1 == 'youtube'){
        jQuery(".show"+val1+"type").show();
        jQuery(".showmapstype").hide();
        jQuery(".showeditortype").hide();
        jQuery(".showvimeotype").hide();
		jQuery(".showproduct").hide();
    }
    if(val1 =='maps'){
        jQuery(".show"+val1+"type").show();
        jQuery(".showyoutubetype").hide();
        jQuery(".showeditortype").hide();
        jQuery(".showvimeotype").hide();
		jQuery(".showproduct").hide();
    }
    if(val1 == 'vimeo'){
        jQuery(".show"+val1+"type").show();
        jQuery(".showyoutubetype").hide();
        jQuery(".showeditortype").hide();
        jQuery(".showmapstype").hide();
		jQuery(".showproduct").hide();
    }
	if(val1 == 'product'){
		jQuery(".show"+val1).show();
		jQuery(".showyoutubetype").hide();
		jQuery(".showeditortype").hide();
		jQuery(".showmapstype").hide();
		jQuery(".showvimeotype").hide();
	}
    if(val1==''){
        jQuery(".show"+checkselected+"type").show();
		jQuery(".show"+checkselected).show();
        
    }
     return checkedradio = $('[name="choose_using"]:radio').val();
}
function changetype(val){
    if(checkedradio == 'all-product'){
        if(val == 'editor'){
            jQuery(".show"+val+"type").show();
            jQuery(".showyoutubetype").hide();
            jQuery(".showmapstype").hide();
            jQuery(".showvimeotype").hide();
            jQuery(".showtitle").show();
			jQuery(".showproduct").hide();
            val1 = val;
        }
        if(val == 'youtube'){
            jQuery(".show"+val+"type").show();
            jQuery(".showmapstype").hide();
            jQuery(".showeditortype").hide();
            jQuery(".showvimeotype").hide();
            jQuery(".showtitle").show();
			 jQuery(".showproduct").hide();
            val1 = val;
        }
        if(val == 'maps'){
            jQuery(".show"+val+"type").show();
            jQuery(".showyoutubetype").hide();
            jQuery(".showeditortype").hide();
            jQuery(".showvimeotype").hide();
            jQuery(".showtitle").show();
			jQuery(".showproduct").hide();
            val1 = val;
        }
        if(val == 'vimeo'){
            jQuery(".show"+val+"type").show();
            jQuery(".showyoutubetype").hide();
            jQuery(".showeditortype").hide();
            jQuery(".showmapstype").hide();
            jQuery(".showtitle").show();
			jQuery(".showproduct").hide();
            val1 = val;
        }
		if(val == 'product'){
            jQuery(".show"+val).show();
            jQuery(".showyoutubetype").hide();
            jQuery(".showeditortype").hide();
            jQuery(".showmapstype").hide();
			jQuery(".showtitle").show();
			jQuery(".showvimeotype").hide();
			val1 = val;
		}
        if(val == 'tag' || val == 'description' || val =='datasheet' || val == 'review'){
            jQuery(".showtitle").hide();
            jQuery(".display").hide();

        }
        
    }else{
         if(val == 'editor' || val == 'youtube' || val =='maps' || val == 'vimeo' || val == 'product'){
            jQuery(".showtitle").show();
            jQuery(".display").hide();
            val1 = val;
        }

        
        if(val == 'tag'){
            jQuery(".showtitle").hide();
            jQuery(".display").hide();
            val1 = val;
        }
        if(val == 'description'){
            jQuery(".showtitle").hide();
            jQuery(".display").hide();
            val1 = val;
        }
        if(val == 'datasheet'){
            jQuery(".showtitle").hide();
            jQuery(".display").hide();
            val1 = val;
        }
        if(val == 'review'){
            jQuery(".showtitle").hide();
            jQuery(".display").hide();
            val1 = val;
        }
    }
	
}
var check = $('.selectproduct').val();
	if (check == 'manual') {
		jQuery(".manual").show();
		//jQuery(".hidemanual").hide();
		
	}
	if ( check == 'newproduct' || check == 'special' || check == 'popular' || check == 'bestseller' || check == 'random') {
		jQuery(".manual").hide();
		jQuery(".hidemanual").show();
	}
function changeproductedit(value) {
	if (value == 'manual') {
		jQuery(".manual").show();
		jQuery(".hidemanual").hide();
	}
	if ( value == 'newproduct' || value == 'special' || value == 'popular' || value == 'bestseller' || check == 'random') {
		jQuery(".manual").hide();
		jQuery(".hidemanual").show();
	}
}
</script>