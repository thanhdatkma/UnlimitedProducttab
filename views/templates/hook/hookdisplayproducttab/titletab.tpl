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

{literal} 
<script src="http://maps.google.com/maps/api/js?sensor=false"></script>
<script>
  function initMap(map_id,lat,lng) {
    var myLatLng = {lat: lat, lng: lng};
    var mapDiv = document.getElementById(map_id);
    var map = new google.maps.Map(mapDiv, {
      center: myLatLng,
      zoom: 8
    });
    //////
    var marker = new google.maps.Marker({
        position: myLatLng,
        map: map,
     });

  }
</script>
{/literal} 
<div id="parentHorizontalTab">
    <ul class="resp-tabs-list hor_1">
        {foreach from=$rows item=value}
        {assign var=arr_lang value=$value.tab_title|json_decode:1}
            {foreach from=$arr_lang key=key_lang item=title_lang}
            {*$arr_lang|var_dump*}
                {if $value.typetab == 'editor'}
                    {if $title_lang !='' && $key_lang == $check_lang}
                        <li>{$title_lang|escape:'htmlall':'UTF-8'}</li>
                    {/if}
                {/if}
                
                {if $value.typetab == 'youtube'}
                    {if $title_lang !='' && $key_lang == $check_lang}
                        <li>{$title_lang|escape:'htmlall':'UTF-8'}</li>
                    {/if}
                {/if}
                
                {if $value.typetab == 'maps'}
                    {if $title_lang !='' && $key_lang == $check_lang}
                        <li>{$title_lang|escape:'htmlall':'UTF-8'}</li>
                    {/if}
                {/if}
                
                {if $value.typetab == 'vimeo' }
                    {if $title_lang !='' && $key_lang == $check_lang}
                        <li>{$title_lang|escape:'htmlall':'UTF-8'}</li>
                    {/if}
                {/if}
                
                {if $value.typetab == 'product'}
                    {assign var=titleproduct value=$value.content_tab|json_decode:1}
                    {if $value.content_tab|strpos:'newproduct' && $new_products}
                        {if $title_lang !='' && $key_lang == $check_lang}
                            <li>{$title_lang|escape:'htmlall':'UTF-8'}</li>
                        {/if}   
                    {/if}
                    
                    {if $value.content_tab|strpos:'popular' && $products}
                        {if $title_lang !='' && $key_lang == $check_lang}
                            <li>{$title_lang|escape:'htmlall':'UTF-8'}</li>
                        {/if}   
                    {/if}
                    
                    {if $value.content_tab|strpos:'bestseller' && $best_sellers}
                        {if $title_lang !='' && $key_lang == $check_lang}
                            <li>{$title_lang|escape:'htmlall':'UTF-8'}</li>
                        {/if}   
                    {/if}
                    
                    {if $value.content_tab|strpos:'special' && $specials}
                        {if $title_lang !='' && $key_lang == $check_lang}
                            <li>{$title_lang|escape:'htmlall':'UTF-8'}</li>
                        {/if}   
                    {/if}   
                    
                    {if $value.content_tab|strpos:'manual' && $product_manual}
                        {if $title_lang !='' && $key_lang == $check_lang}
                            <li>{$title_lang|escape:'htmlall':'UTF-8'}</li>
                        {/if}   
                    {/if}
                {/if}
                
                {if $value.typetab == 'description' && $check == '1'}
                    {if $description && $key_lang == $check_lang}
                        <li>{$title_lang|escape:'htmlall':'UTF-8'}</li>
                    {/if}
                {/if}
                
                {if $value.typetab == 'datasheet' && $check == '1'}
                    {if $datasheet && $key_lang == $check_lang}
                        <li>{$title_lang|escape:'htmlall':'UTF-8'}</li>
                    {/if}
                {/if}
                
                {if $value.typetab == 'tag' && $check == '1'}
                    {if $tags && $key_lang == $check_lang}
                        <li>{$title_lang|escape:'htmlall':'UTF-8'}</li>
                    {/if}
                {/if}
                
                {if $value.typetab == 'review' && $check == '1'}
                    {if $comments && $key_lang == $check_lang}
                        <li>{$title_lang|escape:'htmlall':'UTF-8'}</li>
                    {/if}
                {/if}
            {/foreach}
        {/foreach}
    </ul>
    <div class="resp-tabs-container hor_1" >
        {foreach from=$rows item=value}
            {if $value.typetab == 'editor'}
                {if $value.content_tab}
                    <div>
                        {assign var=arrcontent_lang  value=$value.content_tab|json_decode:1}
                        {foreach from = $arrcontent_lang key=keylang item=content_lang}
                            {if $keylang == $check_lang}
                                <div  class="rte_tab">{$content_lang}</div>
                            {/if}
                        {/foreach}
                    </div>
                {/if}
            {/if}
            
            {if $value.typetab == 'youtube'}
                {if $value.content_tab}
                {assign var=size  value=$value.sizeframe|json_decode:1}
                    <div>
                        <div  class= "embed-container" style="width:{$size['width']|escape:'htmlall':'UTF-8'}px; height:{$size['height']|escape:'htmlall':'UTF-8'}px">
                            <iframe  src="//www.youtube.com/embed/{$value.content_tab|escape:'htmlall':'UTF-8'}" frameborder="0" allowfullscreen></iframe>
                        </div>
                    </div>
                {/if}
            {/if}
            
            {if $value.typetab == 'maps'}
                {if $value.content_tab}
                {assign var=size  value=$value.sizeframe|json_decode:1}
                {*assign var=foo value=","|explode:$value.content_tab*}
                {assign var=lat_lng value=$value.content_tab|json_decode:1}
                {assign var=latlng value=","|implode:$lat_lng}
                {assign var=foo value=","|explode:$latlng}
                    <div>
                        <div  class="map-responsive" >
                            <div id="map_{$value.id_tab|escape:'htmlall':'UTF-8'}" style="width:{$size['width']|escape:'htmlall':'UTF-8'}px; height:{$size['height']|escape:'htmlall':'UTF-8'}px; border: 1px solid #DDD;"></div>
                            <script>
                                initMap("map_{$value.id_tab|escape:'htmlall':'UTF-8'}",{$foo[0]|escape:'htmlall':'UTF-8'},{$foo[1]|escape:'htmlall':'UTF-8'});
                            </script>
                        </div>
                    </div>
                {/if}
            {/if}
            
            {if $value.typetab == 'vimeo'}
                {if $value.content_tab}
                {assign var=size  value=$value.sizeframe|json_decode:1}
                    <div>
                        <div class=" embed-container-vimeo" style="width:{$size['width']|escape:'htmlall':'UTF-8'}px; height:{$size['height']|escape:'htmlall':'UTF-8'}px">{$value.content_tab}</div>
                    </div>
                {/if}
            {/if}
            
            {if $value.typetab == 'product'}
                {if $value.content_tab|strpos:'newproduct'}
                    {if $new_products}
                        <div id="product_new" class="block products_block clearfix">
                            {foreach from=$new_products item=product name=newproduct}
                                <div class="block_content" style="display:inline-block; width: 250px; padding:20px 0px;" >
                                    {assign var='liHeight' value=250}
                                    {assign var='nbItemsPerLine' value=4}
                                    {assign var='nbLi' value=$products|@count}
                                    {math equation="nbLi/nbItemsPerLine" nbLi=$nbLi nbItemsPerLine=$nbItemsPerLine assign=nbLines}
                                    {math equation="nbLines*liHeight" nbLines=$nbLines|ceil liHeight=$liHeight assign=ulHeight}
                                    <ul style="height:{$ulHeight|escape:'htmlall':'UTF-8'}px;">
                                    
                                        {math equation="(total%perLine)" total=$smarty.foreach.newproduct.total perLine=$nbItemsPerLine assign=totModulo}
                                        {if $totModulo == 0}{assign var='totModulo' value=$nbItemsPerLine}{/if}
                                        <li style="display="inline-block;" class="ajax_block_product {if $smarty.foreach.newproduct.first}first_item{elseif $smarty.foreach.newproduct.last}last_item{else}item{/if} {if $smarty.foreach.newproduct.iteration%$nbItemsPerLine == 0}last_item_of_line{elseif $smarty.foreach.newproduct.iteration%$nbItemsPerLine == 1} {/if} {if $smarty.foreach.newproduct.iteration > ($smarty.foreach.newproduct.total - $totModulo)}last_line{/if}">
                                            <a href="{$link->getProductLink($product.id_product, null, null, null, $product.id_lang)|escape:'htmlall':'UTF-8'}" title="{$product.name|escape:html:'UTF-8'}" class="product_image"><img src="{$link->getImageLink($product.link_rewrite, $product.id_image, 'home_default')|escape:'htmlall':'UTF-8'}" height="125" width="125" alt="{$product.name|escape:html:'UTF-8'}" />{if isset($product.new) && $product.new == 1}{*<span class="new">{l s='New' mod='homefeatured'}</span>*}{/if}</a>
                                            <div>
                                                {if $product.show_price}
                                                {assign var='specific_prices' value=$product.specific_prices}
                                                    <ul class="product clearfix" style="padding:5px 0px;">
                                                        <li style="height:25px">
                                                            {if $product.specific_prices}
                                                            
                                                                {if $specific_prices.reduction_type == 'percentage'}
                                                                    {*if $smarty.now|date_format:'%Y-%m-%d %H:%M:%S' <= $specific_prices.to && $smarty.now|date_format:'%Y-%m-%d %H:%M:%S' >= $specific_prices.from*}
                                                                        <span class="reduction"><span class="price-percent-reduction">-{$specific_prices.reduction*100|floatval}%</span></span>
                                                                    {*/if*}
                                                                {/if}
                                                                {if $specific_prices.reduction_type == 'amount'}
                                                                    {*if $smarty.now|date_format:'%Y-%m-%d %H:%M:%S' <= $specific_prices.to && $smarty.now|date_format:'%Y-%m-%d %H:%M:%S' >= $specific_prices.from*}
                                                                        <span class="reduction"><span class="price-percent-reduction">-{displayWtPrice p=$specific_prices.reduction|floatval}</span></span>
                                                                    {*/if*}
                                                                {/if}
                                                            {/if}
                                                        </li>
                                                        
                                                        <li>
                                                            <h5 class="s_title_block item"><a class="product-name" href="{$link->getProductLink($product.id_product, null, null, null, $product.id_lang)|escape:'htmlall':'UTF-8'}" title="{$product.name|truncate:50:'...'|escape:'htmlall':'UTF-8':'UTF-8'}">{$product.name|truncate:35:'...'|escape:'htmlall':'UTF-8':'UTF-8'}</a></h5>
                                                            <div class="product_desc"><a href="{$link->getProductLink($product.id_product, null, null, null, $product.id_lang)|escape:'htmlall':'UTF-8'}" title="{l s='More' mod='unlimitedproducttab'}">{$product.description_short|strip_tags|truncate:40:'...'}</a></div>
                                                        </li>
                                                        <li>
                                                            {if $product.specific_prices}
                                                                {assign var='specific_prices' value=$product.specific_prices}
                                                                    <span class="price-discount  product-price">{displayWtPrice p=$product.price}</span>
                                                                    {if $specific_prices.reduction && $specific_prices.reduction_type == 'percentage'}
                                                                        <span class="price old-price product-price">{displayWtPrice p=$product.price + $product.price * $specific_prices.reduction }</span>
                                                                    {/if}
                                                                    {if $specific_prices.reduction && $specific_prices.reduction_type == 'amount'}
                                                                        <span class="price old-price product-price">{displayWtPrice p=$product.price +  $specific_prices.reduction }</span>
                                                                    {/if}
                                                                    {hook h="displayProductPriceBlock" product=$product type="price"}
                                                            {else}
                                                                    <span class="price-discount  product-price">{displayWtPrice p=$product.price}</span>
                                                            {/if}
                                                        </li>
                                                    </ul>
                                                {/if}
                                                        
                                                {if ($product.quantity > 0)}
                                                    <a id="add_to_cart" class="exclusive ajax_add_to_cart_button" rel="ajax_id_product_{$product.id_product|escape:'htmlall':'UTF-8'}" href="{$link->getPageLink('cart')|escape:'htmlall':'UTF-8'}?add=1&amp;id_product={$product.id_product|escape:'htmlall':'UTF-8'}&amp;ipa={$product.id_product_attribute|intval}&amp;token={$static_token|escape:'htmlall':'UTF-8'}&amp;add" title="{l s='Add to cart' mod='unlimitedproducttab'}" data-id-product-attribute="{$product.id_product_attribute|intval}" data-id-product="{$product.id_product|intval}" data-minimal_quantity="{if isset($product.product_attribute_minimal_quantity) && $product.product_attribute_minimal_quantity >= 1}{$product.product_attribute_minimal_quantity|intval}{else}{$product.minimal_quantity|intval}{/if}">{l s='Add to cart' mod='unlimitedproducttab'}</a>
                                                {else}
                                                    <span  class="exclusive ajax_add_to_cart_button">{l s='Add to cart' mod='unlimitedproducttab'}</span>
                                                {/if}
                                            </div>
                                        </li>
                                
                                    </ul>
                                </div>
                                
                            {/foreach}
                        </div>
                    {/if}
                {/if}
                
                {if $value.content_tab|strpos:'bestseller'}
                    {if $best_sellers}
                        <div id="product_new" class="block products_block clearfix">
                            {foreach from=$best_sellers item=product name=bestsales}
                                <div class="block_content" style="display:inline-block; width: 250px; padding:20px 0px;" >
                                    {assign var='liHeight' value=250}
                                    {assign var='nbItemsPerLine' value=4}
                                    {assign var='nbLi' value=$products|@count}
                                    {math equation="nbLi/nbItemsPerLine" nbLi=$nbLi nbItemsPerLine=$nbItemsPerLine assign=nbLines}
                                    {math equation="nbLines*liHeight" nbLines=$nbLines|ceil liHeight=$liHeight assign=ulHeight}
                                    <ul style="height:{$ulHeight|escape:'htmlall':'UTF-8'}px;">
                                    
                                        {math equation="(total%perLine)" total=$smarty.foreach.bestsales.total perLine=$nbItemsPerLine assign=totModulo}
                                        {if $totModulo == 0}{assign var='totModulo' value=$nbItemsPerLine}{/if}
                                        <li style="display="inline-block;" class="ajax_block_product {if $smarty.foreach.bestsales.first}first_item{elseif $smarty.foreach.bestsales.last}last_item{else}item{/if} {if $smarty.foreach.bestsales.iteration%$nbItemsPerLine == 0}last_item_of_line{elseif $smarty.foreach.bestsales.iteration%$nbItemsPerLine == 1} {/if} {if $smarty.foreach.bestsales.iteration > ($smarty.foreach.bestsales.total - $totModulo)}last_line{/if}">
                                            <a href="{$link->getProductLink($product.id_product, null, null, null, $product.id_lang)|escape:'htmlall':'UTF-8'}" title="{$product.name|escape:html:'UTF-8'}" class="product_image"><img src="{$link->getImageLink($product.link_rewrite, $product.id_image, 'home_default')|escape:'htmlall':'UTF-8'}" height="125" width="125" alt="{$product.name|escape:html:'UTF-8'}" />{if isset($product.new) && $product.new == 1}{*<span class="new">{l s='New' mod='homefeatured'}</span>*}{/if}</a>
                                            <div>
                                                {if $product.show_price}
                                                {assign var='specific_prices' value=$product.specific_prices}
                                                    <ul class="product clearfix" style="padding:5px 0px;">
                                                        <li style="height:25px">
                                                            {if $product.specific_prices}
                                                            
                                                                {if $specific_prices.reduction_type == 'percentage'}
                                                                    {*if $smarty.now|date_format:'%Y-%m-%d %H:%M:%S' <= $specific_prices.to && $smarty.now|date_format:'%Y-%m-%d %H:%M:%S' >= $specific_prices.from*}
                                                                        <span class="reduction"><span class="price-percent-reduction">-{$specific_prices.reduction*100|floatval}%</span></span>
                                                                    {*/if*}
                                                                {/if}
                                                                {if $specific_prices.reduction_type == 'amount'}
                                                                    {*if $smarty.now|date_format:'%Y-%m-%d %H:%M:%S' <= $specific_prices.to && $smarty.now|date_format:'%Y-%m-%d %H:%M:%S' >= $specific_prices.from*}
                                                                        <span class="reduction"><span class="price-percent-reduction">-{displayWtPrice p=$specific_prices.reduction|floatval}</span></span>
                                                                    {*/if*}
                                                                {/if}
                                                            {/if}
                                                        </li>
                                                        
                                                        <li>
                                                            <h5 class="s_title_block item"><a class="product-name" href="{$link->getProductLink($product.id_product, null, null, null, $product.id_lang)|escape:'htmlall':'UTF-8'}" title="{$product.name|truncate:50:'...'|escape:'htmlall':'UTF-8':'UTF-8'}">{$product.name|truncate:35:'...'|escape:'htmlall':'UTF-8':'UTF-8'}</a></h5>
                                                            <div class="product_desc"><a href="{$link->getProductLink($product.id_product, null, null, null, $product.id_lang)|escape:'htmlall':'UTF-8'}" title="{l s='More' mod='unlimitedproducttab'}">{$product.description_short|strip_tags|truncate:40:'...'}</a></div>
                                                        </li>
                                                        <li>
                                                            {if $product.specific_prices}
                                                                {assign var='specific_prices' value=$product.specific_prices}
                                                                    <span class="price-discount  product-price">{displayWtPrice p=$product.price}</span>
                                                                    {if $specific_prices.reduction && $specific_prices.reduction_type == 'percentage'}
                                                                        <span class="price old-price product-price">{displayWtPrice p=$product.price + $product.price * $specific_prices.reduction }</span>
                                                                    {/if}
                                                                    {if $specific_prices.reduction && $specific_prices.reduction_type == 'amount'}
                                                                        <span class="price old-price product-price">{displayWtPrice p=$product.price +  $specific_prices.reduction }</span>
                                                                    {/if}
                                                                    {hook h="displayProductPriceBlock" product=$product type="price"}
                                                            {else}
                                                                    <span class="price-discount  product-price">{displayWtPrice p=$product.price}</span>
                                                            {/if}
                                                        </li>
                                                    </ul>
                                                {/if}
                                                        
                                                {if ($product.quantity > 0)}
                                                    <a id="add_to_cart" class="exclusive ajax_add_to_cart_button" rel="ajax_id_product_{$product.id_product|escape:'htmlall':'UTF-8'}" href="{$link->getPageLink('cart')|escape:'htmlall':'UTF-8'}?add=1&amp;id_product={$product.id_product|escape:'htmlall':'UTF-8'}&amp;ipa={$product.id_product_attribute|intval}&amp;token={$static_token|escape:'htmlall':'UTF-8'}&amp;add" title="{l s='Add to cart' mod='unlimitedproducttab'}" data-id-product-attribute="{$product.id_product_attribute|intval}" data-id-product="{$product.id_product|intval}" data-minimal_quantity="{if isset($product.product_attribute_minimal_quantity) && $product.product_attribute_minimal_quantity >= 1}{$product.product_attribute_minimal_quantity|intval}{else}{$product.minimal_quantity|intval}{/if}">{l s='Add to cart' mod='unlimitedproducttab'}</a>
                                                {else}
                                                    <span  class="exclusive ajax_add_to_cart_button">{l s='Add to cart' mod='unlimitedproducttab'}</span>
                                                {/if}
                                            </div>
                                        </li>
                                
                                    </ul>
                                </div>
                                
                            {/foreach}
                        </div>
                    {/if}
                {/if}
                
                
                {if $value.content_tab|strpos:'special'}
                    {if $specials}
                        <div id="product_special" class="block products_block clearfix">
                            {foreach from=$specials item=product name=special}
                                <div class="block_content" style="display:inline-block; width: 250px; padding:20px 0px;" >
                                    {assign var='liHeight' value=250}
                                    {assign var='nbItemsPerLine' value=4}
                                    {assign var='nbLi' value=$products|@count}
                                    {math equation="nbLi/nbItemsPerLine" nbLi=$nbLi nbItemsPerLine=$nbItemsPerLine assign=nbLines}
                                    {math equation="nbLines*liHeight" nbLines=$nbLines|ceil liHeight=$liHeight assign=ulHeight}
                                    <ul style="height:{$ulHeight|escape:'htmlall':'UTF-8'}px;">
                                    
                                        {math equation="(total%perLine)" total=$smarty.foreach.special.total perLine=$nbItemsPerLine assign=totModulo}
                                        {if $totModulo == 0}{assign var='totModulo' value=$nbItemsPerLine}{/if}
                                        <li style="display="inline-block;" class="ajax_block_product {if $smarty.foreach.special.first}first_item{elseif $smarty.foreach.special.last}last_item{else}item{/if} {if $smarty.foreach.special.iteration%$nbItemsPerLine == 0}last_item_of_line{elseif $smarty.foreach.special.iteration%$nbItemsPerLine == 1} {/if} {if $smarty.foreach.special.iteration > ($smarty.foreach.special.total - $totModulo)}last_line{/if}">
                                            <a href="{$link->getProductLink($product.id_product, null, null, null, $product.id_lang)|escape:'htmlall':'UTF-8'}" title="{$product.name|escape:html:'UTF-8'}" class="product_image"><img src="{$link->getImageLink($product.link_rewrite, $product.id_image, 'home_default')|escape:'htmlall':'UTF-8'}" height="125" width="125" alt="{$product.name|escape:html:'UTF-8'}" />{if isset($product.new) && $product.new == 1}{*<span class="new">{l s='New' mod='homefeatured'}</span>*}{/if}</a>
                                            <div>
                                                {if $product.show_price}
                                                    <ul class="product clearfix" style="padding:5px 0px;">
                                                        <li style="height:25px">
                                                            {if $product.specific_prices}
                                                            {assign var='specific_prices' value=$product.specific_prices}
                                                                {if $specific_prices.reduction_type == 'percentage'}
                                                                    {*if $smarty.now|date_format:'%Y-%m-%d %H:%M:%S' <= $specific_prices.to && $smarty.now|date_format:'%Y-%m-%d %H:%M:%S' >= $specific_prices.from*}
                                                                        <span class="reduction"><span class="price-percent-reduction">-{$specific_prices.reduction*100|floatval}%</span></span>
                                                                    {*/if*}
                                                                {/if}
                                                                {if $specific_prices.reduction_type == 'amount'}
                                                                    {*if $smarty.now|date_format:'%Y-%m-%d %H:%M:%S' <= $specific_prices.to && $smarty.now|date_format:'%Y-%m-%d %H:%M:%S' >= $specific_prices.from*}
                                                                        <span class="reduction"><span class="price-percent-reduction">-{displayWtPrice p=$specific_prices.reduction|floatval}</span></span>
                                                                    {*/if*}
                                                                {/if}
                                                            {/if}
                                                        </li>
                                                        
                                                        <li>
                                                            <h5 class="s_title_block item"><a class="product-name" href="{$link->getProductLink($product.id_product, null, null, null, $product.id_lang)|escape:'htmlall':'UTF-8'}" title="{$product.name|truncate:50:'...'|escape:'htmlall':'UTF-8':'UTF-8'}">{$product.name|truncate:35:'...'|escape:'htmlall':'UTF-8':'UTF-8'}</a></h5>
                                                            <div class="product_desc"><a href="{$link->getProductLink($product.id_product, null, null, null, $product.id_lang)|escape:'htmlall':'UTF-8'}" title="{l s='More' mod='unlimitedproducttab'}">{$product.description_short|strip_tags|truncate:40:'...'}</a></div>
                                                        </li>
                                                        <li>
                                                            {if $product.specific_prices}
                                                                {assign var='specific_prices' value=$product.specific_prices}
                                                                    <span class="price-discount  product-price">{displayWtPrice p=$product.price}</span>
                                                                    {if $specific_prices.reduction && $specific_prices.reduction_type == 'percentage'}
                                                                        <span class="price old-price product-price">{displayWtPrice p=$product.price + $product.price * $specific_prices.reduction }</span>
                                                                    {/if}
                                                                    {if $specific_prices.reduction && $specific_prices.reduction_type == 'amount'}
                                                                        <span class="price old-price product-price">{displayWtPrice p=$product.price +  $specific_prices.reduction }</span>
                                                                    {/if}
                                                                    {hook h="displayProductPriceBlock" product=$product type="price"}
                                                            {/if}
                                                        </li>
                                                    </ul>
                                                {/if}
                                                        
                                                {if ($product.quantity > 0)}
                                                    <a id="add_to_cart" class="exclusive ajax_add_to_cart_button" rel="ajax_id_product_{$product.id_product|escape:'htmlall':'UTF-8'}" href="{$link->getPageLink('cart')|escape:'htmlall':'UTF-8'}?add=1&amp;id_product={$product.id_product|escape:'htmlall':'UTF-8'}&amp;ipa={$product.id_product_attribute|intval}&amp;token={$static_token|escape:'htmlall':'UTF-8'}&amp;add" title="{l s='Add to cart' mod='unlimitedproducttab'}" data-id-product-attribute="{$product.id_product_attribute|intval}" data-id-product="{$product.id_product|intval}" data-minimal_quantity="{if isset($product.product_attribute_minimal_quantity) && $product.product_attribute_minimal_quantity >= 1}{$product.product_attribute_minimal_quantity|intval}{else}{$product.minimal_quantity|intval}{/if}">{l s='Add to cart' mod='unlimitedproducttab'}</a>
                                                {else}
                                                    <span  class="exclusive ajax_add_to_cart_button">{l s='Add to cart' mod='unlimitedproducttab'}</span>
                                                {/if}
                                            </div>
                                        </li>
                                
                                    </ul>
                                </div>
                                
                            {/foreach}
                        </div>
                    
                    {/if}
                
                {/if}
                
                
                {if $value.content_tab|strpos:'popular'}
                    {if $products}
                        <div id="featured-products_block_center" class="block products_block clearfix">
                            {foreach from=$products item=product name=homeFeaturedProducts}
                                <div class="block_content" style="display:inline-block; width: 250px; padding:20px 0px;" >
                                    {assign var='liHeight' value=250}
                                    {assign var='nbItemsPerLine' value=4}
                                    {assign var='nbLi' value=$products|@count}
                                    {math equation="nbLi/nbItemsPerLine" nbLi=$nbLi nbItemsPerLine=$nbItemsPerLine assign=nbLines}
                                    {math equation="nbLines*liHeight" nbLines=$nbLines|ceil liHeight=$liHeight assign=ulHeight}
                                    <ul style="height:{$ulHeight|escape:'htmlall':'UTF-8'}px;">
                                    
                                        {math equation="(total%perLine)" total=$smarty.foreach.homeFeaturedProducts.total perLine=$nbItemsPerLine assign=totModulo}
                                        {if $totModulo == 0}{assign var='totModulo' value=$nbItemsPerLine}{/if}
                                        <li style="display="inline-block;" class="ajax_block_product {if $smarty.foreach.homeFeaturedProducts.first}first_item{elseif $smarty.foreach.homeFeaturedProducts.last}last_item{else}item{/if} {if $smarty.foreach.homeFeaturedProducts.iteration%$nbItemsPerLine == 0}last_item_of_line{elseif $smarty.foreach.homeFeaturedProducts.iteration%$nbItemsPerLine == 1} {/if} {if $smarty.foreach.homeFeaturedProducts.iteration > ($smarty.foreach.homeFeaturedProducts.total - $totModulo)}last_line{/if}">
                                            <a href="{$link->getProductLink($product.id_product, null, null, null, $product.id_lang)|escape:'htmlall':'UTF-8'}" title="{$product.name|escape:html:'UTF-8'}" class="product_image"><img src="{$link->getImageLink($product.link_rewrite, $product.id_image, 'home_default')|escape:'htmlall':'UTF-8'}" height="125" width="125" alt="{$product.name|escape:html:'UTF-8'}" />{if isset($product.new) && $product.new == 1}{*<span class="new">{l s='New' mod='homefeatured'}</span>*}{/if}</a>
                                            
                                            <div>
                                                {if $product.show_price}
                                                {assign var='specific_prices' value=$product.specific_prices}
                                                    <ul class="product clearfix" style="padding:5px 0px;">
                                                        <li style="height:25px">
                                                            {if $product.specific_prices}
                                                            
                                                                {if $specific_prices.reduction_type == 'percentage'}
                                                                    {*if $smarty.now|date_format:'%Y-%m-%d %H:%M:%S' <= $specific_prices.to && $smarty.now|date_format:'%Y-%m-%d %H:%M:%S' >= $specific_prices.from*}
                                                                        <span class="reduction"><span class="price-percent-reduction">-{$specific_prices.reduction*100|floatval}%</span></span>
                                                                    {*/if*}
                                                                {/if}
                                                                {if $specific_prices.reduction_type == 'amount'}
                                                                    {*if $smarty.now|date_format:'%Y-%m-%d %H:%M:%S' <= $specific_prices.to && $smarty.now|date_format:'%Y-%m-%d %H:%M:%S' >= $specific_prices.from*}
                                                                        <span class="reduction"><span class="price-percent-reduction">-{displayWtPrice p=$specific_prices.reduction|floatval}</span></span>
                                                                    {*/if*}
                                                                {/if}
                                                            {/if}
                                                        </li>
                                                        
                                                        <li>
                                                            <h5 class="s_title_block item"><a class="product-name" href="{$link->getProductLink($product.id_product, null, null, null, $product.id_lang)|escape:'htmlall':'UTF-8'}" title="{$product.name|truncate:50:'...'|escape:'htmlall':'UTF-8':'UTF-8'}">{$product.name|truncate:35:'...'|escape:'htmlall':'UTF-8':'UTF-8'}</a></h5>
                                                            <div class="product_desc"><a href="{$link->getProductLink($product.id_product, null, null, null, $product.id_lang)|escape:'htmlall':'UTF-8'}" title="{l s='More' mod='unlimitedproducttab'}">{$product.description_short|strip_tags|truncate:40:'...'}</a></div>
                                                        </li>
                                                        <li>
                                                            {if $product.specific_prices}
                                                                {assign var='specific_prices' value=$product.specific_prices}
                                                                    <span class="price-discount  product-price">{displayWtPrice p=$product.price}</span>
                                                                    {if $specific_prices.reduction && $specific_prices.reduction_type == 'percentage'}
                                                                        <span class="price old-price product-price">{displayWtPrice p=$product.price + $product.price * $specific_prices.reduction }</span>
                                                                    {/if}
                                                                    {if $specific_prices.reduction && $specific_prices.reduction_type == 'amount'}
                                                                        <span class="price old-price product-price">{displayWtPrice p=$product.price +  $specific_prices.reduction }</span>
                                                                    {/if}
                                                                    {hook h="displayProductPriceBlock" product=$product type="price"}
                                                            {else}
                                                                    <span class="price-discount  product-price">{displayWtPrice p=$product.price}</span>
                                                            {/if}
                                                        </li>
                                                    </ul>
                                                {/if}
                                                        
                                                {if ($product.quantity > 0)}
                                                    <a id="add_to_cart" class="exclusive ajax_add_to_cart_button" rel="ajax_id_product_{$product.id_product|escape:'htmlall':'UTF-8'}" href="{$link->getPageLink('cart')|escape:'htmlall':'UTF-8'}?add=1&amp;id_product={$product.id_product|escape:'htmlall':'UTF-8'}&amp;ipa={$product.id_product_attribute|intval}&amp;token={$static_token|escape:'htmlall':'UTF-8'}&amp;add" title="{l s='Add to cart' mod='unlimitedproducttab'}" data-id-product-attribute="{$product.id_product_attribute|intval}" data-id-product="{$product.id_product|intval}" data-minimal_quantity="{if isset($product.product_attribute_minimal_quantity) && $product.product_attribute_minimal_quantity >= 1}{$product.product_attribute_minimal_quantity|intval}{else}{$product.minimal_quantity|intval}{/if}">{l s='Add to cart' mod='unlimitedproducttab'}</a>
                                                {else}
                                                    <span  class="exclusive ajax_add_to_cart_button">{l s='Add to cart' mod='unlimitedproducttab'}</span>
                                                {/if}
                                            </div>
                                        </li>
                                
                                    </ul>
                                </div>
                                
                            {/foreach}
                        </div>
                    {/if}
                {/if}
                
                {if $value.content_tab|strpos:'manual'}
                    {if $product_manual}
                        <div id="product_manual" class="block products_block clearfix">
                            {foreach from=$product_manual item=product name=manual}
                                <div class="block_content" style="display:inline-block; width: 250px; padding:20px 0px;" >
                                    {assign var='liHeight' value=250}
                                    {assign var='nbItemsPerLine' value=4}
                                    {assign var='nbLi' value=$products|@count}
                                    {math equation="nbLi/nbItemsPerLine" nbLi=$nbLi nbItemsPerLine=$nbItemsPerLine assign=nbLines}
                                    {math equation="nbLines*liHeight" nbLines=$nbLines|ceil liHeight=$liHeight assign=ulHeight}
                                    <ul style="height:{$ulHeight|escape:'htmlall':'UTF-8'}px;">
                                    
                                        {math equation="(total%perLine)" total=$smarty.foreach.manual.total perLine=$nbItemsPerLine assign=totModulo}
                                        {if $totModulo == 0}{assign var='totModulo' value=$nbItemsPerLine}{/if}
                                        <li style="display="inline-block;" class="ajax_block_product {if $smarty.foreach.manual.first}first_item{elseif $smarty.foreach.manual.last}last_item{else}item{/if} {if $smarty.foreach.manual.iteration%$nbItemsPerLine == 0}last_item_of_line{elseif $smarty.foreach.manual.iteration%$nbItemsPerLine == 1} {/if} {if $smarty.foreach.manual.iteration > ($smarty.foreach.manual.total - $totModulo)}last_line{/if}">
                                            <a href="{$link->getProductLink($product.id_product, null, null, null, $product.id_lang)|escape:'htmlall':'UTF-8'}" title="{$product.name|escape:html:'UTF-8'}" class="product_image"><img src="{$link->getImageLink($product.link_rewrite, $product.id_image, 'home_default')|escape:'htmlall':'UTF-8'}" height="125" width="125" alt="{$product.name|escape:html:'UTF-8'}" />{if isset($product.new) && $product.new == 1}{*<span class="new">{l s='New' mod='homefeatured'}</span>*}{/if}</a>
                                            
                                            <div>
                                                {if $product.show_price}
                                                    <ul class="product clearfix" style="padding:5px 0px;">
                                                        <li style="height:25px">
                                                            {if $product.reduction}
                                                                {if $product.reduction_type == 'percentage'}
                                                                    <span class="reduction"><span class="price-percent-reduction">-{$product.reduction*100|floatval}%</span></span>
                                                                {else}
                                                                    <span class="reduction"><span class="price-percent-reduction">-{displayWtPrice p=$product.reduction|floatval}</span></span>
                                                                {/if}
                                                            {/if}
                                                        </li>
                                                        
                                                        <li>
                                                            <h5 class="s_title_block item"><a class="product-name" href="{$link->getProductLink($product.id_product, null, null, null, $product.id_lang)|escape:'htmlall':'UTF-8'}" title="{$product.name|truncate:50:'...'|escape:'htmlall':'UTF-8':'UTF-8'}">{$product.name|truncate:35:'...'|escape:'htmlall':'UTF-8':'UTF-8'}</a></h5>
                                                            <div class="product_desc"><a href="{$link->getProductLink($product.id_product, null, null, null, $product.id_lang)|escape:'htmlall':'UTF-8'}" title="{l s='More' mod='unlimitedproducttab'}">{$product.description_short|strip_tags|truncate:40:'...'}</a></div>
                                                        </li>
                                                        <li>
                                                                <span class="price-discount  product-price">{displayWtPrice p=$product.price}</span>
                                                                {if $product.reduction && $product.reduction_type == 'percentage'}
                                                                    <span class="price old-price product-price">{displayWtPrice p=$product.price + $product.price * $product.reduction }</span>
                                                                {/if}
                                                                {if $product.reduction && $product.reduction_type == 'amount'}
                                                                    <span class="price old-price product-price">{displayWtPrice p=$product.price +  $product.reduction }</span>
                                                                {/if}
                                                                {hook h="displayProductPriceBlock" product=$product type="price"}
                                                        </li>
                                                    </ul>
                                                {/if}
                                                        
                                                {if ($product.quantity > 0)}
                                                    <a id="add_to_cart" class="exclusive ajax_add_to_cart_button" rel="ajax_id_product_{$product.id_product|escape:'htmlall':'UTF-8'}" href="{$link->getPageLink('cart')|escape:'htmlall':'UTF-8'}?add=1&amp;id_product={$product.id_product|escape:'htmlall':'UTF-8'}&amp;ipa={$product.id_product_attribute|intval}&amp;token={$static_token|escape:'htmlall':'UTF-8'}&amp;add" title="{l s='Add to cart' mod='unlimitedproducttab'}" data-id-product-attribute="{$product.id_product_attribute|intval}" data-id-product="{$product.id_product|intval}" data-minimal_quantity="{if isset($product.product_attribute_minimal_quantity) && $product.product_attribute_minimal_quantity >= 1}{$product.product_attribute_minimal_quantity|intval}{else}{$product.minimal_quantity|intval}{/if}">{l s='Add to cart' mod='unlimitedproducttab'}</a>
                                                {else}
                                                    <span  class="exclusive ajax_add_to_cart_button">{l s='Add to cart' mod='unlimitedproducttab'}</span>
                                                {/if}
                                            </div>
                                        </li>
                                
                                    </ul>
                                </div>
                                
                            {/foreach}
                        </div>
                    {/if}
                {/if}
            {/if}
            
            
            
            
            {if $value.typetab == 'description' && $check == '1'}
                {if $description}
                    <div>
                        <div  class="rte_tab review">{$description}</div>
                    </div>
                {/if}
            {/if}
            
            {if $value.typetab == 'datasheet' && $check == '1'}
                {if $datasheet}
                    <div>
                        <table class="table_datasheet review">          
                            {foreach from=$datasheet item=feature}
                                <tr class="">           
                                    <td>{$feature.name|escape:'htmlall':'UTF-8'}</td><td> {$feature.value|escape:'htmlall':'UTF-8'}</td>
                                </tr>
                            {/foreach}
                        </table>
                    </div>
                {/if}
            {/if}
            
            {if $value.typetab == 'tag' && $check == '1' }
                {if $tags}
                    <div>
                        <div  class="rte_tab review">
                            <div class="tagify-container">
                                {foreach from=$tags item=tag}
                                    <a href="{$link->getPageLink('search', true, NULL, "tag={$tag|urlencode}")|escape:'htmlall':'UTF-8'}">
                                        <span style="display: inline-block; padding: 2px 5px;margin: 3px;border-radius: 2px; border: 1px solid #00aff0;background-color: #3ecbff;color: #fff;">
                                        {$tag|escape:'htmlall':'UTF-8'}
                                        </span>
                                    </a>
                                {/foreach}
                            </div>
                        </div>
                    </div>
                {/if}
            {/if}
            
            {if $value.typetab == 'review' && $check == '1'}
                {if $comments}
                    <div>
                        <div  class="rte_tab review">{$comments}</div>
                    </div>
                {/if}
            {/if}
        {/foreach}
    </div>
</div>
{if $check == '1'}
    {literal}
        <script>
            $(".table-data-sheet").parent().hide();
            $(".idTabHrefShort").hide();
            
        </script>
    {/literal}
{else}
    {literal}
        <script>
            $(".review").hide();
        </script>
    {/literal}  
{/if}
<script type="text/javascript">
    $(document).ready(function() {
        //Horizontal Tab
        $('#parentHorizontalTab').easyResponsiveTabs({
            type: 'default', //Types: default, vertical, accordion
            width: 'auto', //auto or any width like 600px
            fit: true, // 100% fit in a container
            tabidentify: 'hor_1', // The tab groups identifier
            activate: function(event) { // Callback function if tab is switched
                var $tab = $(this);
                var $info = $('#nested-tabInfo');
                var $name = $('span', $info);
                $name.text($tab.text());
                $info.show();
            }
        });

        // Child Tab
        $('#ChildVerticalTab_1').easyResponsiveTabs({
            type: 'vertical',
            width: 'auto',
            fit: true,
            tabidentify: 'ver_1', // The tab groups identifier
            activetab_bg: '#fff', // background color for active tabs in this group
            inactive_bg: '#F5F5F5', // background color for inactive tabs in this group
            active_border_color: '#c1c1c1', // border color for active tabs heads in this group
            active_content_border_color: '#5AB1D0' // border color for active tabs contect in this group so that it matches the tab head border
        });

        //Vertical Tab
        $('#parentVerticalTab').easyResponsiveTabs({
            type: 'vertical', //Types: default, vertical, accordion
            width: 'auto', //auto or any width like 600px
            fit: true, // 100% fit in a container
            closed: 'accordion', // Start closed if in accordion view
            tabidentify: 'hor_1', // The tab groups identifier
            activate: function(event) { // Callback function if tab is switched
                var $tab = $(this);
                var $info = $('#nested-tabInfo2');
                var $name = $('span', $info);
                $name.text($tab.text());
                $info.show();
            }
        });
    });
</script>