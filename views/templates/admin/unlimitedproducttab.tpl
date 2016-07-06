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

<ul class="nav nav-tabs">
    <li class="{if $taskbar=="addProductTab"}active{/if}">
  		<a href="{$bamodule|escape:'htmlall':'UTF-8'}&configure={$configure|escape:'htmlall':'UTF-8'}&token={$token|escape:'htmlall':'UTF-8'}&task=addProductTab">{l s='Tab Products' mod='unlimitedproducttab'}</a>
 	</li>
    <li class="{if $taskbar=="configurationTab"}active{/if}">
 	 	<a href="{$bamodule|escape:'htmlall':'UTF-8'}&configure={$configure|escape:'htmlall':'UTF-8'}&token={$token|escape:'htmlall':'UTF-8'}&configure={$configure|escape:'htmlall':'UTF-8'}&task=configurationTab">{l s='Configuration' mod='unlimitedproducttab'}</a>
	</li>
</ul>