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
<script type="text/javascript">
	function baHideOtherLanguage(id_lang, iso_lang){
		$(".language_view").html(iso_lang+' <span class="caret"></span>');
		$(".lang>div").css("display","none");
		$(".lang>div.language_"+iso_lang).css("display","block");
	    $(".iso_code_now").attr("data-iso-choose",iso_lang);
	}
</script>
{foreach from=$rows item=value}
	<div class="panel">
	{assign var=title value=$value.tab_title|json_decode:1}
	{foreach from=$title key=key_title item=title_lang}
		<h3>{if $key_title == $iso_default_language}{$title_lang|escape:'htmlall':'UTF-8'}{/if}</h3>	
	{/foreach}	
		{*<h3>{$value.tab_title|escape:'htmlall':'UTF-8'}</h3>*}	
		<div class="form-group">										
			<label class="control-label col-lg-3">{l s='Display' mod='unlimitedproducttab'}:</label>
			<div class="col-lg-9">
				 <div class="radio">
					<label>
						<input  type="radio" name="tab[{$value.id_tab|escape:'htmlall':'UTF-8'}][status]" id="active_on" value="1" checked = "checked" />{l s='Yes' mod='unlimitedproducttab'}
					</label>
				</div>
				<div class="radio">
					<label>
						<input type="radio" name="tab[{$value.id_tab|escape:'htmlall':'UTF-8'}][status]" id="active_on" value="0" >{l s='No' mod='unlimitedproducttab'}
					</label>
				</div>
			</div>
		</div>
		{if $value.typetab == 'editor'}
			<div class="form-group display showeditortype">
				<label class="control-label col-lg-3 ">{l s='Content' mod='unlimitedproducttab'}:</label>
				<div class="col-lg-9 " style="width: 55%;">
					<div class="lang {$iso_default_language|escape:'htmlall':'UTF-8'}" data-iso-default="{$iso_default_language|escape:'htmlall':'UTF-8'}">
					   {foreach from=$arr_language key =key_lang item=language}
							<div class="language_{$language.iso_code|escape:'htmlall':'UTF-8'} iso_code" data-iso="{$language.iso_code|escape:'htmlall':'UTF-8'}" style="{if $id_default_language == $language.id_lang}display:block;{/if} {if $id_default_language != $language.id_lang}display:none;{/if}" >
								 <textarea class="rte" name="tab[{$value.id_tab|escape:'htmlall':'UTF-8'}][content][{$language.iso_code|escape:'htmlall':'UTF-8'}]">
								 </textarea>
							</div>
					   {/foreach}
					</div>
				</div>
				<div class="col-lg-2">
					<div class="col-lg-1">
						<button type="button" class="btn btn-default dropdown-toggle language_view iso_code_now" data-toggle="dropdown" tabindex="-1" data-iso-choose="{$iso_default_language|escape:'htmlall':'UTF-8'}" >
							{$iso_default_language|escape:'htmlall':'UTF-8'}
							<span class="caret"></span>
						</button>
						<ul class="dropdown-menu">
							{foreach $arr_language key =key_lang item=language}
								<li>
									<a  href="javascript:void(0);" onclick="baHideOtherLanguage('{$language.id_lang|escape:'htmlall':'UTF-8'}','{$language.iso_code|escape:'htmlall':'UTF-8'}')">{$language.name|escape:'htmlall':'UTF-8'}</a>
								</li>
							{/foreach}
						</ul>
					</div>
				</div>
			</div>			
		{/if}
		{if $value.typetab == 'youtube'}
		<div class="form-group   showyoutubetype" >
			<label class="control-label col-lg-3 ">{l s='Link Youtube:' mod='unlimitedproducttab'}</label>
			<div class="col-lg-9">
				<input type="text" name="tab[{$value.id_tab|escape:'htmlall':'UTF-8'}][content]"  value="{$value.content|escape:'htmlall':'UTF-8'}">
			</div>
			<label class="control-label col-lg-3 ">{l s=' ' mod='unlimitedproducttab'}</label>
			<div class="col-lg-9 ">
				<p class="help-block">{l s='Input link youtube' mod='unlimitedproducttab'}</p>
			</div>
			<div class="form-group   showyoutubetype" >
				<label class="control-label col-lg-3">{l s='Width:' mod='unlimitedproducttab'}</label>
				<div class="col-lg-9">
					<div style="display:inline-block">
						<input  style="width:100px;" type="text" value="560" name="tab[{$value.id_tab|escape:'htmlall':'UTF-8'}][size][width]" />
					</div>
					<div style="width:100px; display:inline-block">
						<label class="control-label">px</label>
					</div>
				</div><br />
				<label class="control-label col-lg-3">{l s='Height:' mod='unlimitedproducttab'}</label>
				<div class="col-lg-9" >
					<div style="display:inline-block">
						<input style="width:100px;" type="text" value="315" name="tab[{$value.id_tab|escape:'htmlall':'UTF-8'}][size][height]"/>
					</div>
					<div style="width:100px; display:inline-block">
						<label class="control-label">px</label>
					</div>
				</div>	
			</div>
		</div>	
		{/if}
		{if $value.typetab == 'maps'}
		<div class="form-group" style="display:none;">
			<label class="control-label col-lg-3 ">Address:</label> 
			<div class="col-lg-9">
				<input name= "add" id="addresspicker_map_{$value.id_tab|escape:'htmlall':'UTF-8'}" />
			</div>
		</div>	
		<div class="form-group  showmapstype"   >
			<label class="control-label col-lg-3 ">{l s=' ' mod='unlimitedproducttab'}</label>
			<div style="col-lg-9">
				<div class="map-responsive">
					<div id="map_{$value.id_tab|escape:'htmlall':'UTF-8'}" class="" style="width:560px;height:315px;border: 1px solid #DDD;"></div>
				</div>		
			</div>
			<label class="control-label col-lg-3 ">{l s=' ' mod='unlimitedproducttab'}</label>
			<div class="col-lg-9" style = "float: left;">
				<p class="help-block">{l s='You can drag and drop the marker to the correct location' mod='unlimitedproducttab'}</p>
			</div>
		</div>
		
		<div class="form-group">
			<label class="control-label col-lg-3 ">{l s='Width:' mod='unlimitedproducttab'}</label>
			<div clsass="col-lg-9">
				<div style="display:inline-block">
					<input style="width:100px;" type="text" value="560" name="tab[{$value.id_tab|escape:'htmlall':'UTF-8'}][size][width]" />
				</div>
				<div style="width:100px; display:inline-block">
					<label class="control-label">px</label>
				</div>
			</div><br />
			<label class="control-label col-lg-3">{l s='Height:' mod='unlimitedproducttab'}</label>
			<div class="col-lg-9" >
				<div style="display:inline-block">	
					<input style="width:100px;" type="text" value="315" name="tab[{$value.id_tab|escape:'htmlall':'UTF-8'}][size][height]"/>
				</div>
				<div style="width:100px; display:inline-block">
					<label class="control-label">px</label>
				</div>
			</div>
		</div>
		
		<div class="form-group"  style="display:none;" >
			<label  class="control-label col-lg-3 ">Lat:</label>
			<div class="col-lg-9">
				<input value="" id="lat_{$value.id_tab|escape:'htmlall':'UTF-8'}" name="tab[{$value.id_tab|escape:'htmlall':'UTF-8'}][content][lat]" />
			</div> <br/>
		</div>
		<div class="form-group"  style="display:none;" >
			<label  class="control-label col-lg-3 ">Lng:</label>
			<div class="col-lg-9">
				<input   id="lng_{$value.id_tab|escape:'htmlall':'UTF-8'}" name="tab[{$value.id_tab|escape:'htmlall':'UTF-8'}][content][lng]"/>
			</div>
		</div>
			<script type="text/javascript">
					$(function() {
					var addresspickerMap = $( "#addresspicker_map_{$value.id_tab|escape:'htmlall':'UTF-8'}" ).addresspicker({
					regionBias: 'fr',
					language: 'fr',
					updateCallback: showCallback,
					mapOptions: {
					zoom: 8,
					center: new google.maps.LatLng(46, 2),
					scrollwheel: false,
					mapTypeId: google.maps.MapTypeId.ROADMAP
				  },
				  elements: {
					map:      "#map_{$value.id_tab|escape:'htmlall':'UTF-8'}",
					lat:      "#lat_{$value.id_tab|escape:'htmlall':'UTF-8'}",
					lng:      "#lng_{$value.id_tab|escape:'htmlall':'UTF-8'}",
				  }
				});

				var gmarker = addresspickerMap.addresspicker( 'marker');
				gmarker.setVisible(true);
				addresspickerMap.addresspicker( 'updatePosition');

				$('#reverseGeocode').change(function(){
				  $("#addresspicker_map_{$value.id_tab|escape:'htmlall':'UTF-8'}").addresspicker('option', 'reverseGeocode', ($(this).val() === 'true'));
				});

				function showCallback(geocodeResult, parsedGeocodeResult){
				  $('#callback_result').text(JSON.stringify(parsedGeocodeResult, null, 4));
				}
				// Update zoom field
				var map = $("#addresspicker_map_{$value.id_tab|escape:'htmlall':'UTF-8'}").addresspicker('map');
				google.maps.event.addListener(map, 'idle', function(){
				  $('#zoom').val(map.getZoom());
				});

			  });
			  </script>
		{/if}
		{if $value.typetab == 'vimeo'}
		<div class="form-group   showvimeotype" style="display:{if $value.typetab == 'vimeo'}block;{else}none;{/if}" >
			<label class="control-label col-lg-3 ">{l s='Link Vimeo' mod='unlimitedproducttab'}:</label>
			<div class="col-lg-9">
				<textarea name="tab[{$value.id_tab|escape:'htmlall':'UTF-8'}][content]"  cols="10" rows="10"  style="width:100%;">{$value.content|escape:'htmlall':'UTF-8'}</textarea>
			</div>
			<label class="control-label col-lg-3 ">{l s=' ' mod='unlimitedproducttab'}</label>
			<div class="col-lg-9 ">
				<p class="help-block">{l s='Input link vimeo' mod='unlimitedproducttab'}</p>
			</div>
		</div>	
		<div class="form-group   showvimeotype" >
			<label class="control-label col-lg-3 ">{l s='Width:' mod='unlimitedproducttab'}</label>
			<div clsass="col-lg-9" >
				<div style="display:inline-block">
					<input style="width:100px;" type="text" value="560" name="tab[{$value.id_tab|escape:'htmlall':'UTF-8'}][size][width]" />
				</div>
				<div style="width:100px; display:inline-block">
					<label class="control-label">px</label>
				</div>
			</div><br />
			<label class="control-label col-lg-3">{l s='Height:' mod='unlimitedproducttab'}</label>
			<div class="col-lg-9">
				<div style="display:inline-block">
					<input style="width:100px;" type="text" value="315" name="tab[{$value.id_tab|escape:'htmlall':'UTF-8'}][size][height]"/>
				</div>
				<div style="width:100px; display:inline-block">
					<label class="control-label">px</label>
				</div>
			</div>
		</div>
		
		
		{/if}
		{if  $value.typetab == 'tag'}
			<label class="control-label col-lg-3 ">{l s=' ' mod='unlimitedproducttab'}</label>
			<div class="col-lg-9 " style = "float: left;">
				<p class="help-block">{l s='This Tab Content will automatic get from Product Infomation' mod='unlimitedproducttab'}</p>
			</div>
		{/if}
		{if  $value.typetab == 'description'}
			<label class="control-label col-lg-3 ">{l s=' ' mod='unlimitedproducttab'}</label>
			<div class="col-lg-9 " style = "float: left;">
				<p class="help-block">{l s='This Tab Content will automatic get from Product Infomation' mod='unlimitedproducttab'}</p>
			</div>
		{/if}
		{if  $value.typetab == 'datasheet'}
			<label class="control-label col-lg-3 ">{l s=' ' mod='unlimitedproducttab'}</label>
			<div class="col-lg-9 " style = "float: left;">
				<p class="help-block">{l s='This Tab Content will automatic get from Product Features' mod='unlimitedproducttab'}</p>
			</div>
		{/if}
		{if  $value.typetab == 'review'}
			<label class="control-label col-lg-3 ">{l s=' ' mod='unlimitedproducttab'}</label>
			<div class="col-lg-9 " style = "float: left;">
				<p class="help-block">{l s='This Tab Content will automatic get from Product Comment module' mod='unlimitedproducttab'}</p>
			</div>
		{/if}
	</div>
{/foreach}


