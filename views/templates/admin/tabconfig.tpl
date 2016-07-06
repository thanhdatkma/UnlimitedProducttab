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
		<div class="form-group">	
		<label class="control-label col-lg-3" >{l s='Remove Product Tab Default' mod='unlimitedproducttab'}: </label>		
			<div class="col-lg-9">
				<span class="switch prestashop-switch fixed-width-lg">
					<input type="radio" name="active" id="active_on" value="1" {if $checkconfig == '1'}checked="checked"{/if}>
					<label for="active_on"  class="radioCheck">
						Yes
					</label>
					<input type="radio" name="active" id="active_off" value="0"  {if $checkconfig == '0'}checked="checked"{/if}>
					<label for="active_off" class="radioCheck">
						No
					</label>
					<a class="slide-button btn btn-default"></a>
				</span>
			</div>
		</div>
		<div class="panel-footer">
		<button type="submit" class="btn btn-default pull-right" name="unlimited-savestay-tab"><i class="process-icon-save"></i> {l s='Save & Stay' mod='unlimitedproducttab'}</button>
	</div>
	</div>
</form>

