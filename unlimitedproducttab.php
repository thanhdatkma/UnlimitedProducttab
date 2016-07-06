<?php
/**
* 2007-2016 PrestaShop
*
* NOTICE OF LICENSE
*
* This source file is subject to the Open Software License(OSL 3.0)
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
*  @author    Buy-Addons <hatt@buy-addons.com>
*  @copyright 2007-2016 PrestaShop SA
*  @license   http://opensource.org/licenses/osl-3.0.php  Open Software License(OSL 3.0)
*  International Registered Trademark & Property of PrestaShop SA
*/

class UnlimitedProductTab extends Module
{
    public $query;
    public $tag;
    public $key_lang;
    public $iso_code;
    public function __construct()
    {
        $this->name = "unlimitedproducttab";
        $this->tab = "advertising_marketing";
        $this->version = "1.0.0";
        $this->author = "buy-addons";
        $this->need_instance = 0;
        $this->bootstrap = true;
        $this->displayName = $this->l('Unlimited Product Tab');
        $this->description = $this->l('Author: buy-addons');
        parent::__construct();
    }

    public function install()
    {
        /* config */
        Configuration::updateValue('display_status', '1');
        /* create table Database */
        
        $this->createTable();
        
        if (parent::install()== false
            || !$this->registerHook("displayAdminProductsExtra")
            || !$this->registerHook("actionObjectProductAddAfter")
            || !$this->registerHook("actionObjectProductUpdateAfter")
            || !$this->registerHook("displayProductTab")
            || !$this->registerHook("displayHeader")
            || !$this->registerHook("displayBackOfficeHeader")
            || !$this->registerHook("displayBackOfficeFooter")) {
            return false;
        }
        return true;
    }
    public function hookDisplayHeader($params)
    {
        $this->context->controller->addCSS($this->_path . 'views/css/datasheet.css');
        // $this->context->controller->addCSS($this->_path . 'views/css/productcomments.css');
        $this->context->controller->addJS($this->_path . 'views/js/easyResponsiveTabs.js');
        $this->context->controller->addCSS($this->_path . 'views/css/easy-responsive-tabs.css');
        
        
    }
    public function hookDisplayBackOfficeHeader($params)
    {
        if (Tools::isSubmit('addproduct') || Tools::isSubmit('updateproduct')) {
                
                $gmaps = 'http://ajax.googleapis.com/ajax/libs/jqueryui/1.10.3/jquery-ui.min.js';
                $this->context->controller->addJS(Media::getJqueryPath());
                $this->context->controller->addJS('http://maps.google.com/maps/api/js?sensor=false');
                $this->context->controller->addJS($gmaps);
                $this->context->controller->addJS($this->_path . 'views/js/jquery.ui.addresspicker.js');
                $this->context->controller->addCSS($this->_path . 'views/css/demo.css');
                $this->context->controller->addCSS($this->_path . 'views/css/jquery.ui.all.css');
                $this->context->controller->addCSS($this->_path . 'views/css/datasheet.css');
        }
    }
    public function hookDisplayProductTab(&$params)
    {
        $id_product = Tools::getValue('id_product');
        $check = configuration::get('display_status');
        $check_lang = $this->context->language->iso_code;
        $check_id_lang = $this->context->language->id;
        $this->smarty->assign('check_id_lang', $check_id_lang);
        $this->smarty->assign('check_lang', $check_lang);
        $arr = $params['product']->tags;
        // var_dump($arr);
        // die;
        $tag = array();
        if (empty($arr)) {
            $tag = null;
            $this->smarty->assign('tags', $tag);
        } else {
            foreach ($arr as $arrtag) {
                $tag = $arrtag;
            }
            $this->smarty->assign('tags', $tag);
        }
        $description = $params['product']->description;
        $po = new product($id_product, false, $this->context->language->id);
        $datasheet = $po->getFrontFeatures($this->context->language->id);
        $this->smarty->assign('check', $check);
        $this->smarty->assign('datasheet', $datasheet);
        if ($check == '1') {
            $params['product']->description = null;
            $this->smarty->assign('description', $description);
            return $this->displayproducttab();
        } else {
            $this->smarty->assign('description', '');
            return $this->displayproducttab();
        }
    }

    public function displayproducttab()
    {
        $db = DB::getInstance();
        $id_product =(int)Tools::getValue('id_product');
        $sqlproduct = 'SELECT id_category_default FROM '._DB_PREFIX_.'product WHERE id_product = '.$id_product;
        $id_category_default = $db->executeS($sqlproduct);
        $sql = 'SELECT content FROM '._DB_PREFIX_.'tabproducts WHERE typetab = "product"';
        $rowsCheck = $db->ExecuteS($sql);
        $id_lang = (int) $this->context->language->id;
        if ($rowsCheck) {
            foreach ($rowsCheck as $value) {
                $typeProduct = Tools::JsonDecode($value['content']);
                $params = array (
                    'id_lang'               =>(int)$id_lang,
                    'id_category_default'   =>(int)$id_category_default[0]['id_category_default'],
                    'checkid_category'      =>(int)$typeProduct[2],
                    'start'                 =>0,
                    'count'                 =>(int)$typeProduct[1],
                );
                if (strpos($value['content'], 'newproduct')) {
                    // echo"<pre>";
                    // var_dump($params);
                    // die;
                    // $id_categorydefault = (int)$id_category_default[0]['id_category_default'];
                    // $count = (int)$typeProduct[1];
                    // $same_category = (int)$typeProduct[2];
                    if ((int)$typeProduct[2] == 1) {
                        $new_products = $this->getNewProducts($params);
                    } else {
                        $new_products = $this->getNewProducts($params);
                    }
                }
                
                if (strpos($value['content'], 'popular')) {
                    // $id_category = (int)$id_category_default[0]['id_category_default'];
                    // $count = (int)$typeProduct[1];
                    // $same_category = (int)$typeProduct[2];
                    $popular = $this->getProducts($params, 8, null, null, false, true, true);
                }
                
                if (strpos($value['content'], 'bestseller')) {
                    // $id_category = (int)$id_category_default[0]['id_category_default'];
                    // $count = (int)$typeProduct[1];
                    // $same_category = (int)$typeProduct[2];
                    $bestseller = $this->getBestSales($params, null, null);
                }
                if (strpos($value['content'], 'special')) {
                    $id_category = (int)$id_category_default[0]['id_category_default'];
                    $count = (int)$typeProduct[1];
                    $same_category = (int)$typeProduct[2];
                    if ((int)$typeProduct[2] == 1) {
                        $special = $this->getRandomSpecial($same_category, (int)$id_category, $count);
                    } else {
                        $special = $this->getRandomSpecial($same_category, (int)$id_category, $count);
                    }
                }
                
                if (strpos($value['content'], 'manual')) {
                    $arr_id_product = $typeProduct[3];
                    $all_Products =$this->getAllProducts($params, 'id_product', 'ASC', false, false);
                }
            }
            
            $id_product_manual = explode(',', $arr_id_product);
            $arr_product_manual = array();
            foreach ($id_product_manual as $value_manual) {
                foreach ($all_Products as $key => $value) {
                    if ((int)$value_manual == (int)$all_Products[$key]['id_product']) {
                        $arr_product_manual[] = $value;
                    }
                }
            }
            $this->smarty->assign('new_products', $new_products);
            $this->smarty->assign('products', $popular);
            $this->smarty->assign('best_sellers', $bestseller);
            $this->smarty->assign('specials', $special);
            $this->smarty->assign('product_manual', $arr_product_manual);
            
        }
        
        $sql = 'SELECT * FROM
        '. _DB_PREFIX_ .'product_tab INNER JOIN
        '. _DB_PREFIX_ .'tabproducts ON
        '. _DB_PREFIX_ . 'product_tab.id_tab ='. _DB_PREFIX_ . 'tabproducts.id_tab
        AND id_product =' . $id_product .' AND display = 1 AND statustab = 1
        AND using_tab = "config-tab" ORDER BY tab_position ASC';
        $rows = $db->ExecuteS($sql);
        $sql1 = 'SELECT id_tab,tab_title,content AS content_tab,typetab,tab_position,sizeframe_all AS sizeframe FROM
        '. _DB_PREFIX_ . 'tabproducts WHERE using_tab ="all-product" AND statustab = 1';
        $rows1 = $db->ExecuteS($sql1);
        $rows = array_merge($rows, $rows1);
        //////
        $n = count($rows);
        for ($i = 0; $i < $n - 1; $i++) {
            for ($j = $i + 1; $j < $n; $j++) {
                if ($rows[$j]['tab_position'] < $rows[$i]['tab_position']) {
                    $tmp = $rows[$j];
                    $rows[$j] = $rows[$i];
                    $rows[$i] = $tmp;
                }
            }
        }

        $arrRow = array();
        foreach ($rows as $perrow) {
            $arrRow[] = $perrow;
        }
        $this->smarty->assign('rows', $arrRow);
        // require_once(_PS_MODULE_DIR_ . 'productcomments/ProductCommentCriterion.php');
        // require_once(_PS_MODULE_DIR_ . 'productcomments/ProductComment.php');
        // require_once(_PS_MODULE_DIR_ . 'productcomments/productcomments.php');
        $filename = _PS_MODULE_DIR_. 'productcomments/productcomments.php';
        if (file_exists($filename)) {
                $comments = new ProductComments();
                $params = array();
                $params['product']['id_product'] = $id_product;
                $comments_list = $comments->hookProductTabContent($params);
        } else {
                $comments_list = '';
        }
        $this->context->smarty->assign('comments', $comments_list);
        return $this->display(__FILE__, 'views/templates/hook/hookdisplayproducttab/titletab.tpl');
    }
    // get popular product in category.php
    public function getProducts($params, $n, $order_by, $order_way, $get_total, $active, $random, $context = null)
    {
        if (!$context) {
            $context = Context::getContext();
        }

        $front = in_array($context->controller->controller_type, array('front', 'modulefront'));
        $id_supplier = (int)Tools::getValue('id_supplier');

        /** Return only the number of products */
        if ($get_total) {
            $sql = 'SELECT COUNT(cp.`id_product`) AS total
                    FROM `'._DB_PREFIX_.'product` p
                    '.Shop::addSqlAssociation('product', 'p').'
                    LEFT JOIN `'._DB_PREFIX_.'category_product` cp ON p.`id_product` = cp.`id_product`
                    WHERE cp.`id_category` = '.(int)$this->id.
                ($front ? ' AND product_shop.`visibility` IN ("both", "catalog")' : '').
                ($active ? ' AND product_shop.`active` = 1' : '').
                ($id_supplier ? 'AND p.id_supplier = '.(int)$id_supplier : '');

            return (int)Db::getInstance(_PS_USE_SQL_SLAVE_)->getValue($sql);
        }

        if ($params['start'] < 1) {
            $params['start']= 1;
        }

        /** Tools::strtolower is a fix for all modules which are now using lowercase values for 'orderBy' parameter */
        $order_by  = Validate::isOrderBy($order_by)   ? Tools::strtolower($order_by)  : 'position';
        $order_way = Validate::isOrderWay($order_way) ? Tools::strtoupper($order_way) : 'ASC';

        $order_by_prefix = false;
        if ($order_by == 'id_product' || $order_by == 'date_add' || $order_by == 'date_upd') {
            $order_by_prefix = 'p';
        } elseif ($order_by == 'name') {
            $order_by_prefix = 'pl';
        } elseif ($order_by == 'manufacturer' || $order_by == 'manufacturer_name') {
            $order_by_prefix = 'm';
            $order_by = 'name';
        } elseif ($order_by == 'position') {
            $order_by_prefix = 'cp';
        }

        if ($order_by == 'price') {
            $order_by = 'orderprice';
        }

        $nb_days_new_product = Configuration::get('PS_NB_DAYS_NEW_PRODUCT');
        if (!Validate::isUnsignedInt($nb_days_new_product)) {
            $nb_days_new_product = 20;
        }
        
        if ((int)$params['checkid_category'] == 1) {
            $id_categorydefault = 'AND p.`id_category_default` = '.(int)$params['id_category_default'];
        } else {
            $id_categorydefault = '';
        }
            $sql = 'SELECT p.*, product_shop.*, stock.out_of_stock, '
                        .' IFNULL(stock.quantity, 0) AS quantity'.(Combination::isFeatureActive() ? ', '
                        .' IFNULL(product_attribute.id_product_attribute, 0) AS id_product_attribute,'
                        .' product_attribute.minimal_quantity AS product_attribute_minimal_quantity' : '').', '
                        .' pl.`description`, pl.`description_short`, pl.`available_now`,'
                        .' pl.`available_later`, pl.`link_rewrite`, pl.`meta_description`,'
                        .' pl.`meta_keywords`, pl.`meta_title`, pl.`name`, image.`id_image` id_image,'
                        .' il.`legend` as legend, m.`name` AS manufacturer_name, cl.`name` AS category_default,'
                        .' DATEDIFF(product_shop.`date_add`, DATE_SUB("'.date('Y-m-d').' 00:00:00",'
                        .' INTERVAL '.(int)$nb_days_new_product.' DAY)) > 0 AS new, product_shop.price AS orderprice'
                    .' FROM `'._DB_PREFIX_.'category_product` cp '
                    .'LEFT JOIN `'._DB_PREFIX_.'product` p ON p.`id_product` = cp.`id_product` '
                    .Shop::addSqlAssociation('product', 'p').(Combination::isFeatureActive() ? ' 
                    LEFT JOIN `'._DB_PREFIX_.'product_attribute` product_attribute
                    ON (p.`id_product` = product_attribute.`id_product`'
                    .' AND product_attribute.`default_on` = 1 )':'').' '.Product::sqlStock('p', 0).'
                    LEFT JOIN `'._DB_PREFIX_.'category_lang` cl'
                        .' ON (product_shop.`id_category_default` = cl.`id_category`'
                        .' AND cl.`id_lang` = '.(int)$params['id_lang'].Shop::addSqlRestrictionOnLang('cl').')'
                    .' LEFT JOIN `'._DB_PREFIX_.'product_lang` pl
                        ON (p.`id_product` = pl.`id_product`
                        AND pl.`id_lang` = '.(int)$params['id_lang'].Shop::addSqlRestrictionOnLang('pl').')
                    LEFT JOIN `'._DB_PREFIX_.'image` image
                        ON (p.`id_product` = image.`id_product` AND image.cover=1)
                    LEFT JOIN `'._DB_PREFIX_.'image_shop` image_shop'
                        .' ON (image.`id_image` = image_shop.`id_image`'
                        .' AND image_shop.id_shop='.(int)$context->shop->id.' )'
                    .' LEFT JOIN `'._DB_PREFIX_.'image_lang` il
                        ON (image_shop.`id_image` = il.`id_image`'
                        .' AND il.`id_lang` = '.(int)$params['id_lang'].')
                    LEFT JOIN `'._DB_PREFIX_.'manufacturer` m
                        ON m.`id_manufacturer` = p.`id_manufacturer`'
                    .' LEFT JOIN `'._DB_PREFIX_.'specific_price` sp ON (sp.`id_product` = p.`id_product`)'
                    .' WHERE product_shop.`id_shop` = '.(int)$context->shop->id.' '.$id_categorydefault.' '
                        .($active ? ' AND product_shop.`active` = 1' : '')
                        .($front ? ' AND product_shop.`visibility` IN ("both", "catalog")' : '')
                        .($id_supplier ? ' AND p.id_supplier = '.(int)$id_supplier : '')
                        .' GROUP BY cp.id_product';
        
        if ($random === true) {
            $sql .= ' ORDER BY RAND() LIMIT '.(int)$params['count'];
        } else {
            $sql .= ' ORDER BY '.(!empty($order_by_prefix) ? $order_by_prefix
            .'.' : '').'`'.bqSQL($order_by).'` '.pSQL($order_way).'
            LIMIT '.(((int)$params['start'] - 1) * (int)$n).','.(int)$n;
        }
        // echo"<pre>";
        // var_dump($sql);
        // die;
        $result = Db::getInstance(_PS_USE_SQL_SLAVE_)->executeS($sql, true, false);

        if ($order_by == 'orderprice') {
            Tools::orderbyPrice($result, $order_way);
        }
        /** Modify SQL result */
        return Product::getProductsProperties((int)$params['id_lang'], $result);
    }
    
    //getnew product
    public function getNewProducts($params, $count = false, $order_by = null, $order_way = null, $context = null)
    {
        if (!$context) {
            $context = Context::getContext();
        }

        $front = true;
        if (!in_array($context->controller->controller_type, array('front', 'modulefront'))) {
            $front = false;
        }

        if ($params['start'] < 0) {
            $params['start'] = 0;
        }
        if ($params['count'] < 1) {
            $params['count'] = 10;
        }
        if (empty($order_by) || $order_by == 'position') {
            $order_by = 'date_add';
        }
        if (empty($order_way)) {
            $order_way = 'DESC';
        }
        if ($order_by == 'id_product' || $order_by == 'price' || $order_by == 'date_add' || $order_by == 'date_upd') {
            $order_by_prefix = 'p';
        } elseif ($order_by == 'name') {
            $order_by_prefix = 'pl';
        }
        if (!Validate::isOrderBy($order_by) || !Validate::isOrderWay($order_way)) {
            die(Tools::displayError());
        }

        $sql_groups = '';
        if (Group::isFeatureActive()) {
            $groups = FrontController::getCurrentCustomerGroups();
            $sql_groups = ' AND EXISTS(SELECT 1 FROM `'._DB_PREFIX_.'category_product` cp'
                .' JOIN `'._DB_PREFIX_.'category_group` cg'
                .' ON (cp.id_category = cg.id_category AND'
                .' cg.`id_group` '.(count($groups) ? 'IN ('.implode(',', $groups).')' : '= 1').')'
                .' WHERE cp.`id_product` = p.`id_product`)';
        }

        if (strpos($order_by, '.') > 0) {
            $order_by = explode('.', $order_by);
            $order_by_prefix = $order_by[0];
            $order_by = $order_by[1];
        }
        $nb_days_new_product = Configuration::get('PS_NB_DAYS_NEW_PRODUCT');
        $date = date('Y-m-d', strtotime('-'.($nb_days_new_product ? (int)$nb_days_new_product : 20).' DAY'));
        if ($count) {
            $sql = 'SELECT COUNT(p.`id_product`) AS nb
                    FROM `'._DB_PREFIX_.'product` p
                    '.Shop::addSqlAssociation('product', 'p')
                    .' WHERE product_shop.`active` = 1'
                    .' AND product_shop.`date_add` > "'.$date.'"
                    '.($front ? ' AND product_shop.`visibility` IN ("both", "catalog")' : '').'
                    '.$sql_groups;
            return (int)Db::getInstance(_PS_USE_SQL_SLAVE_)->getValue($sql);
        }
        $ps_nb_dayNewProduct = Configuration::get('PS_NB_DAYS_NEW_PRODUCT');
        $sql = new DbQuery();
        $sql->select(
            'p.*, product_shop.*, stock.out_of_stock, IFNULL(stock.quantity, 0) as quantity,'
            .' pl.`description`, pl.`id_lang`, pl.`description_short`, pl.`link_rewrite`, pl.`meta_description`,'
            .' pl.`meta_keywords`, pl.`meta_title`, pl.`name`, pl.`available_now`,'
            .' pl.`available_later`, image.`id_image` id_image, il.`legend`, m.`name` AS manufacturer_name,'
            .' product_shop.`date_add` > "'
            .date('Y-m-d', strtotime('-'.( $ps_nb_dayNewProduct ? (int)$ps_nb_dayNewProduct : 20).' DAY')).'" as new'
        );
        $id_lang_shop = (int)$params['id_lang'].Shop::addSqlRestrictionOnLang('pl');
        $sql->from('product', 'p');
        $sql->join(Shop::addSqlAssociation('product', 'p'));
        $sql->leftJoin('product_lang', 'pl', 'p.`id_product` = pl.`id_product` AND pl.`id_lang` = '.$id_lang_shop);
        $sql->leftJoin('image', 'image', 'image.`id_product` = p.`id_product` AND image.cover=1');
        $image_shop = 'image.`id_image` = image_shop.`id_image` AND image_shop.id_shop=';
        $sql->leftJoin('image_shop', 'image_shop', $image_shop.(int)$params['id_lang']);
        $image_lang = 'image_shop.`id_image` = il.`id_image` AND il.`id_lang` = '.(int)$params['id_lang'];
        $sql->leftJoin('image_lang', 'il', $image_lang);
        $sql->leftJoin('manufacturer', 'm', 'm.`id_manufacturer` = p.`id_manufacturer`');
        $sql->leftJoin('specific_price', 'sp', 'sp.`id_product` =  p.`id_product`');
        $sql->where('product_shop.`active` = 1');
        
        if ((int)$params['checkid_category'] == 1) {
            $sql->where('p.`id_category_default` = '.$params['id_category_default']);
        }
        if ($front) {
            $sql->where('product_shop.`visibility` IN ("both", "catalog")');
        }
        $sql->where('product_shop.`date_add` > "'.$date.'"');
        if (Group::isFeatureActive()) {
            $sql->join('JOIN '._DB_PREFIX_.'category_product cp ON (cp.id_product = p.id_product)');
            $sql->join('JOIN '._DB_PREFIX_.'category_group cg ON (cg.id_category = cp.id_category)');
            $sql->where('cg.`id_group` '.(count($groups) ? 'IN ('.implode(',', $groups).')' : '= 1'));
        }
        $sql->groupBy('product_shop.id_product');
        $prefix = pSQL($order_by_prefix);
        $sql->orderBy((isset($order_by_prefix) ? $prefix.'.' : '').'`'.pSQL($order_by).'` '.pSQL($order_way));
        $start_count = (int)$params['start'] * (int)$params['count'];
        $sql->limit((int)$params['count'], $start_count);
        $product_attribute = 'product_attribute.minimal_quantity AS product_attribute_minimal_quantity';
        if (Combination::isFeatureActive()) {
            $sql->select($product_attribute, 'IFNULL(product_attribute.id_product_attribute,0) id_product_attribute');
            $product_attribute_str = 'p.`id_product` = product_attribute.`id_product`'
                                    .' AND product_attribute.`default_on` = 1 ';
            $sql->leftJoin('product_attribute', 'product_attribute', $product_attribute_str);
        }
        $sql->join(Product::sqlStock('p', 0));
        // echo"<pre>";
        // var_dump($sql);
        // die;
        $result = Db::getInstance(_PS_USE_SQL_SLAVE_)->executeS($sql);
            
        if ($order_by == 'price') {
            Tools::orderbyPrice($result, $order_way);
        }
        if (!$result) {
            return false;
        }

        $products_ids = array();
        foreach ($result as $row) {
            $products_ids[] = $row['id_product'];
        }
        
        // Thus you can avoid one query per product,
        //because there will be only one query
        //for all the products of the cart
        Product::cacheFrontFeatures($products_ids, $params['id_lang']);
        return Product::getProductsProperties((int)$params['id_lang'], $result);
    }
    
    public static function getProductsProperties($id_lang, $query_result)
    {
        $results_array = array();
        if (is_array($query_result)) {
            foreach ($query_result as $row) {
                if ($row2 = Product::getProductProperties($id_lang, $row)) {
                    $results_array[] = $row2;
                }
            }
        }

        return $results_array;
    }
    public static function cacheFrontFeatures($product_ids, $id_lang)
    {
        if (!Feature::isFeatureActive()) {
            return;
        }

        $product_implode = array();
        foreach ($product_ids as $id_product) {
            if ((int)$id_product && !array_key_exists($id_product.'-'.$id_lang, self::$_cacheFeatures)) {
                $product_implode[] = (int)$id_product;
            }
        }
        if (!count($product_implode)) {
            return;
        }
        $slq = 'SELECT id_product, name, value, pf.id_feature'
            .' FROM '._DB_PREFIX_.'feature_product pf'
            .' LEFT JOIN '._DB_PREFIX_.'feature_lang fl'
            .' ON (fl.id_feature = pf.id_feature AND fl.id_lang = '.(int)$id_lang.')'
            .' LEFT JOIN '._DB_PREFIX_.'feature_value_lang fvl'
            .' ON (fvl.id_feature_value = pf.id_feature_value AND fvl.id_lang = '.(int)$id_lang.') '
            .' LEFT JOIN '._DB_PREFIX_.'feature f ON (f.id_feature = pf.id_feature)'
            .Shop::addSqlAssociation('feature', 'f')
            .' WHERE `id_product` IN ('.implode($product_implode, ',').') ORDER BY f.position ASC';
        $result = Db::getInstance(_PS_USE_SQL_SLAVE_)->executeS($slq);

        foreach ($result as $row) {
            if (!array_key_exists($row['id_product'].'-'.$id_lang, self::$_frontFeaturesCache)) {
                self::$_frontFeaturesCache[$row['id_product'].'-'.$id_lang] = array();
            }
            if (!isset(self::$_frontFeaturesCache[$row['id_product'].'-'.$id_lang][$row['id_feature']])) {
                self::$_frontFeaturesCache[$row['id_product'].'-'.$id_lang][$row['id_feature']] = $row;
            }
        }
    }
    
    public function getRandomSpecial($id_checkcategory, $id_category_default, $count)
    {
        
        // $random = Product::getRandomSpecial((int) $this->context->language->id);
        // return $random;
        $db = Db::getInstance();

        $context = Context::getContext();
        if ((int)$id_checkcategory == 1) {
            $id_categorydefault = ' AND p.`id_category_default` = '.$id_category_default;
        } else {
            $id_categorydefault = '';
        }
        $id_lang = (int) $this->context->language->id;
        $nb_days_new_product = Configuration::get('PS_NB_DAYS_NEW_PRODUCT');
        $sql = 'SELECT p.*, product_shop.*, stock.`out_of_stock` out_of_stock,'
                        .' pl.`description`, pl.`description_short`, pl.`id_lang`,'
                        .' pl.`link_rewrite`, pl.`meta_description`, pl.`meta_keywords`,'
                        .' pl.`meta_title`, pl.`name`, pl.`available_now`, pl.`available_later`,'
                        .' p.`ean13`, p.`upc`, image_shop.`id_image` id_image, il.`legend`,'
                        .' DATEDIFF(product_shop.`date_add`, DATE_SUB("'.date('Y-m-d').' 00:00:00",'
                        .' INTERVAL '.(Validate::isUnsignedInt($nb_days_new_product) ? $nb_days_new_product : 20)
                        .' DAY)) > 0 AS new
                    FROM `'._DB_PREFIX_.'product` p'
                    .' LEFT JOIN `'._DB_PREFIX_.'product_lang` pl ON (
                        p.`id_product` = pl.`id_product`'
                        .' AND pl.`id_lang` = '.(int)$id_lang.Shop::addSqlRestrictionOnLang('pl').'
                    )
                    '.Shop::addSqlAssociation('product', 'p').'
                    LEFT JOIN `'._DB_PREFIX_.'specific_price` sp
                        ON p.id_product = sp.id_product
                    LEFT JOIN `'._DB_PREFIX_.'image` image
                        ON (image.`id_product` = p.`id_product` AND image.cover=1 )
                    LEFT JOIN `'._DB_PREFIX_.'image_shop` image_shop'
                        .' ON (image.`id_image` = image_shop.`id_image`'
                        .' AND image_shop.id_shop='.(int)$context->shop->id.' )'
                    .' LEFT JOIN `'._DB_PREFIX_.'image_lang` il ON (image_shop.`id_image` = il.`id_image`'
                    .' AND il.`id_lang` = '.(int)$id_lang.')
                    '.Product::sqlStock('p', 0).'
                    WHERE sp.reduction > 0 '.$id_categorydefault.' ORDER BY RAND() LIMIT '.$count;
        // echo"<pre>";
        // var_dump($sql);
        // die;
        $rows = $db->ExecuteS($sql);

        return $this->getProductsProperties($id_lang, $rows);
    }
    
    public function getAllProducts($params, $order_by, $order_way, $id_category, $only_active, $context = null)
    {
        if (!$context) {
            $context = Context::getContext();
        }
        $front = true;
        if (!in_array($context->controller->controller_type, array('front', 'modulefront'))) {
            $front = false;
        }

        if (!Validate::isOrderBy($order_by) || !Validate::isOrderWay($order_way)) {
            die(Tools::displayError());
        }
        if ($order_by == 'id_product' || $order_by == 'price' || $order_by == 'date_add' || $order_by == 'date_upd') {
            $order_by_prefix = 'p';
        } elseif ($order_by == 'name') {
            $order_by_prefix = 'pl';
        } elseif ($order_by == 'position') {
            $order_by_prefix = 'c';
        }

        if (strpos($order_by, '.') > 0) {
            $order_by = explode('.', $order_by);
            $order_by_prefix = $order_by[0];
            $order_by = $order_by[1];
        }

        $prefix = pSQL($order_by_prefix);
        $sql = 'SELECT p.*, product_shop.*, sa.`quantity`, pl.*, sp.`reduction`,'
                .' sp.`reduction_type`, m.`name` AS manufacturer_name,'
                .' s.`name` AS supplier_name, image_shop.`id_image` id_image
                FROM `'._DB_PREFIX_.'product` p
                '.Shop::addSqlAssociation('product', 'p').' '
                .' INNER JOIN `'._DB_PREFIX_.'stock_available` sa'
                        .' ON ( p.`id_product` = sa.`id_product` AND sa.`id_product_attribute` = 0)'
                .' LEFT JOIN `'._DB_PREFIX_.'product_lang` pl'
                .' ON (p.`id_product` = pl.`id_product` '.Shop::addSqlRestrictionOnLang('pl').')'
                .' LEFT JOIN `'._DB_PREFIX_.'manufacturer` m ON (m.`id_manufacturer` = p.`id_manufacturer`)'
                .' LEFT JOIN `'._DB_PREFIX_.'specific_price` sp ON (sp.`id_product` = p.`id_product`)'
                .' LEFT JOIN `'._DB_PREFIX_.'image` image ON (image.`id_product` = p.`id_product` AND image.cover=1 )'
                .' LEFT JOIN `'._DB_PREFIX_.'image_shop` image_shop'
                .' ON (image.`id_image` = image_shop.`id_image` AND image_shop.id_shop='.(int)$context->shop->id.' )'
                .' LEFT JOIN `'._DB_PREFIX_.'supplier` s ON (s.`id_supplier` = p.`id_supplier`)'.
                ($id_category ? 'LEFT JOIN `'
                ._DB_PREFIX_.'category_product` c ON (c.`id_product` = p.`id_product`)' : '')
                .' WHERE pl.`id_lang` = '.(int)$params['id_lang'].
                    ($id_category ? ' AND c.`id_category` = '.(int)$id_category : '').
                    ($front ? ' AND product_shop.`visibility` IN ("both", "catalog")' : '').
                    ($only_active ? ' AND product_shop.`active` = 1' : '').'
                ORDER BY '.(isset($order_by_prefix) ? $prefix.'.' : '').'`'.pSQL($order_by).'` '.pSQL($order_way).
                ((int)$params['count'] > 0 ? ' LIMIT '.(int)$params['start'].','.(int)$params['count'] : '');
        $rq = Db::getInstance(_PS_USE_SQL_SLAVE_)->ExecuteS($sql);
        
        if ($order_by == 'price') {
            Tools::orderbyPrice($rq, $order_way);
        }

        foreach ($rq as &$row) {
            $row = Product::getTaxesInformations($row);
        }
        // echo"<pre>";
        // var_dump($sql);
        // die;
        return ($rq);
    }
    
    public function getBestSales($params = array(), $order_by = null, $order_way = null)
    {
        if ((int)$params['start'] < 0) {
            $params['start'] = 0;
        }
        $final_order_by = '';
        if ((int)$params['count'] < 1) {
            $params['count'] = 10;
            $final_order_by = $order_by;
            $order_table = '';
        }
        if (is_null($order_by) || $order_by == 'position' || $order_by == 'price') {
            $order_by = 'sales';
        }
        if ($order_by == 'date_add' || $order_by == 'date_upd') {
            $order_table = 'product_shop';
        }
        if (is_null($order_way) || $order_by == 'sales') {
            $order_way = 'DESC';
        }
        $groups = FrontController::getCurrentCustomerGroups();
        $sql_groups = (count($groups) ? 'IN ('.implode(',', $groups).')' : '= 1');
        $nb_days_new_product = Configuration::get('PS_NB_DAYS_NEW_PRODUCT');
        $interval = Validate::isUnsignedInt($nb_days_new_product) ? $nb_days_new_product : 20;
        //Subquery: get product ids in a separate query to (greatly!) improve performances and RAM usage
        $sql = 'SELECT cp.`id_product`
                FROM `'._DB_PREFIX_.'category_group` cg
                LEFT JOIN `'._DB_PREFIX_.'category_product` cp ON (cp.`id_category` = cg.`id_category`)
                WHERE cg.`id_group` '.$sql_groups;
        $products = Db::getInstance(_PS_USE_SQL_SLAVE_)->executeS($sql);
        $ids = array();
        foreach ($products as $product) {
            $ids[$product['id_product']] = 1;
        }
        $ids = array_keys($ids);
        sort($ids);
        $ids = count($ids) > 0 ? implode(',', $ids) : 'NULL';
        if ((int)$params['checkid_category'] == 1) {
            $sql_category_default = 'p.`id_category_default` = '.(int)$params['id_category_default'] .' AND ';
        } else {
            $sql_category_default = '';
        }
        //Main query
        $sql = 'SELECT p.*, product_shop.*, stock.out_of_stock, IFNULL(stock.quantity, 0) as quantity,
                    pl.`description`,  pl.`id_lang`, pl.`description_short`, pl.`link_rewrite`, pl.`meta_description`,
                    pl.`meta_keywords`, pl.`meta_title`, pl.`name`,
                    m.`name` AS manufacturer_name, p.`id_manufacturer` as id_manufacturer,
                    MAX(image_shop.`id_image`) id_image, il.`legend`,
                    ps.`quantity` AS sales, t.`rate`, pl.`meta_keywords`, pl.`meta_title`, pl.`meta_description`,
                    DATEDIFF(p.`date_add`, DATE_SUB(NOW(),
                    INTERVAL '.$interval.' DAY)) > 0 AS new
                FROM `'._DB_PREFIX_.'product_sale` ps
                LEFT JOIN `'._DB_PREFIX_.'product` p ON ps.`id_product` = p.`id_product`
                '.Shop::addSqlAssociation('product', 'p', false).'
                LEFT JOIN `'._DB_PREFIX_.'product_lang` pl
                    ON p.`id_product` = pl.`id_product`
                    AND pl.`id_lang` = '.(int)$params['id_lang'].Shop::addSqlRestrictionOnLang('pl').'
                LEFT JOIN `'._DB_PREFIX_.'image` i ON (i.`id_product` = p.`id_product`)'.
                Shop::addSqlAssociation('image', 'i', false, 'image_shop.cover=1').'
                LEFT JOIN `'._DB_PREFIX_.'image_lang` il'
                .' ON (i.`id_image` = il.`id_image` AND il.`id_lang` = '.(int)$params['id_lang'].')
                LEFT JOIN `'._DB_PREFIX_.'manufacturer` m ON (m.`id_manufacturer` = p.`id_manufacturer`)
                LEFT JOIN `'._DB_PREFIX_.'tax_rule` tr ON (product_shop.`id_tax_rules_group` = tr.`id_tax_rules_group`)
                    AND tr.`id_country` = '.(int)Context::getContext()->country->id.'
                    AND tr.`id_state` = 0
                LEFT JOIN `'._DB_PREFIX_.'tax` t ON (t.`id_tax` = tr.`id_tax`)
                '.Product::sqlStock('p').'
                WHERE  '.$sql_category_default.' product_shop.`active` = 1
                    AND p.`visibility` != \'none\'
                GROUP BY product_shop.id_product
                ORDER BY '.(!empty($order_table) ? '`'
                .pSQL($order_table).'`.' : '').'`'
                .pSQL($order_by).'` '
                .pSQL($order_way).'
                LIMIT '.(int)($params['start'] * (int)$params['count']).', '.(int)$params['count'];
        // echo"<pre>";
        // var_dump($sql);
        // die;
        $result = Db::getInstance(_PS_USE_SQL_SLAVE_)->executeS($sql);

        if ($final_order_by == 'price') {
            Tools::orderbyPrice($result, $order_way);
        }
        if (!$result) {
            return false;
        }
        return Product::getProductsProperties((int)$params['id_lang'], $result);
    }

    public function hookactionObjectProductUpdateAfter($params)
    {
        $id_product = $params['object']->id;
        $db = DB::getInstance();
        $tab = Tools::getValue('tab');
        $content = '';
        $id_default_language = (int) (Configuration::get('PS_LANG_DEFAULT'));
        $iso_default_language = Language::getIsoById($id_default_language);
        foreach ($tab as $keys => $value) {
            $checkdefault = $value['content'][$iso_default_language];
            if (is_array($value['content'])) {
                //$content = Tools::jsonEncode($value['content']);
                $arr_lang = array();
                foreach ($value['content'] as $key => $lang) {
                    if ($checkdefault == '') {
                        if ($lang == '') {
                            $arr_lang[$key] = $lang;
                        } else {
                            $arr_lang[$key] = $lang;
                        }
                    } else {
                        if ($lang !='') {
                            $arr_lang[$key] = $lang;
                        } else {
                            $arr_lang[$key] = $checkdefault;
                        }
                    }
                }
                $arrstrig = Tools::jsonEncode($arr_lang);
                $content = $arrstrig;
            } else {
                $check = strpos($value['content'], 'youtube.com');
                if ($check === false) {
                    $content = $value['content'];
                } else {
                    $arr = parse_url($value['content']);
                    $query = $arr['query'];
                    parse_str($query, $myArray);
                    foreach ($myArray as $key => $array) {
                        if ($key=='v') {
                            $content = $array;
                        }
                    }
                }
            }
            if (is_array($value['size'])) {
                $size = Tools::jsonEncode($value['size']);
            }
            
            $arr = array('content_tab'      => pSQL($content, true),
                            'display'       => (int) $value['status'],
                            'sizeframe'     => pSQL($size));
            $db->update('product_tab', $arr, 'id_product =' .(int) $id_product . ' AND id_tab=' .(int) $keys);
        }
    }

    public function hookactionObjectProductAddAfter($params)
    {
        $db = DB::getInstance();
        $id_product = $params['object']->id;
        $tab = Tools::getValue('tab');
        $content = '';
        $id_default_language = (int) (Configuration::get('PS_LANG_DEFAULT'));
        $iso_default_language = Language::getIsoById($id_default_language);
        // echo"<pre>";
        // var_dump($tab);
        // die;
        foreach ($tab as $keys => $value) {
            $checkdefault = $value['content'][$iso_default_language];
            //var_dump($checkdefault);
            if (is_array($value['content'])) {
                $arr_lang = array();
                foreach ($value['content'] as $key => $lang) {
                    if ($checkdefault == '') {
                        if ($lang == '') {
                            $arr_lang[$key] = $lang;
                        } else {
                            $arr_lang[$key] = $lang;
                        }
                    } else {
                        if ($lang !='') {
                            $arr_lang[$key] = $lang;
                        } else {
                            $arr_lang[$key] = $checkdefault;
                        }
                    }
                }
                $arrstrig = Tools::jsonEncode($arr_lang);
                $content = $arrstrig;
            } else {
                $check = strpos($value['content'], 'youtube.com');
                if ($check === false) {
                    $content = $value['content'];
                } else {
                    $arr = parse_url($value['content']);
                    $query = $arr['query'];
                    parse_str($query, $myArray);
                    foreach ($myArray as $key => $array) {
                        if ($key == 'v') {
                            $content = $array;
                        }
                    }
                }
            }
            if (is_array($value['size'])) {
                $size = Tools::jsonEncode($value['size']);
            }
            $db->insert('product_tab', array('id_product'    =>(int)$id_product,
                                                'id_tab'        =>(int)$keys,
                                                'content_tab'   => pSQL($content, true),
                                                'sizeframe'     => pSQL($size),
                                                'display'       =>(int)$value['status']));
        }
    }
        //echo $this->context->language->iso_code;

    public function hookDisplayAdminProductsExtra($params)
    {
        $id =(int)Tools::getValue('id_product');
        $arr_language = Language::getLanguages(false);
        $this->smarty->assign('arr_language', $arr_language);
        $id_default_language = (int) (Configuration::get('PS_LANG_DEFAULT'));
        $this->smarty->assign('id_default_language', $id_default_language);

        $iso_default_language = Language::getIsoById($id_default_language);
        $this->smarty->assign('iso_default_language', $iso_default_language);
        return $this->checkDisplay($id);
    }

    public function checkDisplay($id)
    {
        $check = '';
        $db = DB::getInstance();
        $link = 'views/templates/hook/hookdisplayadminproductextra/';
        if (empty($id)) {
            $sql = 'SELECT * FROM '. _DB_PREFIX_. 'tabproducts WHERE statustab = 1 '
            . 'AND using_tab ="config-tab" ORDER BY tab_position ASC';
            $rows = $db->ExecuteS($sql);
            $this->smarty->assign('rows', $rows);
            $html = $this->createEditer($check);
            $url = $this->display(__FILE__, $link.'displaytabproductaddnew.tpl');
            return $html.=$url;
        } else {
            $sql = 'SELECT * FROM '
            . _DB_PREFIX_ . 'product_tab INNER JOIN '
            . _DB_PREFIX_ . 'tabproducts ON '
            . _DB_PREFIX_ . 'product_tab.id_tab = '
            . _DB_PREFIX_ . 'tabproducts.id_tab '
            . 'AND id_product = ' .(int)$id . ' ORDER BY tab_position ASC';
            $rows = $db->ExecuteS($sql);
            $this->smarty->assign('rows', $rows);
            $html = $this->createEditer($check);
            $url=$this->display(__FILE__, $link.'displaytabproductupdate.tpl');
            return $html.=$url;
        }
    }

    public function uninstall()
    {
        $this->dropTable();
        if (parent::uninstall()== false) {
            return false;
        }
        return true;
    }

    public function getContent()
    {
        $arr_language = Language::getLanguages(false);
        $this->smarty->assign('arr_language', $arr_language);
        $id_default_language = (int) (Configuration::get('PS_LANG_DEFAULT'));
        $this->smarty->assign('id_default_language', $id_default_language);

        $iso_default_language = Language::getIsoById($id_default_language);
        $this->smarty->assign('iso_default_language', $iso_default_language);
        
        if (Tools::isSubmit('addNewTab')) {
            return $this->createForm();
        }
        
        if (Tools::isSubmit('updateunlimitedproducttab')) {
            return $this->createForm();
        }
        
        if (Tools::isSubmit('statustabunlimitedproducttab')) {
            $id =(int)Tools::getValue('id_tab');
            $db = DB::getInstance();
            $sql = "UPDATE " . _DB_PREFIX_ . 'tabproducts SET statustab = 1-statustab WHERE id_tab =' .(int)$id;
            $db->execute($sql);
        }
        
        if (Tools::isSubmit('deleteunlimitedproducttab')) {
            return $this->deleteTab();
        }
        
        if (Tools::isSubmit('submitBulkdeleteunlimitedproducttab')) {
            return $this->deleteSelect();
        }
        return $this->displayList();
    }

    public function displayList()
    {
        $bamodule = AdminController::$currentIndex;
        $token = Tools::getAdminTokenLite('AdminModules');
        $taskbar = "";
        $this->smarty->assign('token', $token);
        $this->smarty->assign('bamodule', $bamodule);
        $this->smarty->assign('configure', $this->name);
        
        if (Tools::getValue('task')== 'configurationTab') {
            
            if (Tools::isSubmit('unlimited-savestay-tab')) {
                configuration::updateValue('display_status', Tools::getValue('active'));
            }
            $check = configuration::get('display_status');
            $taskbar = Tools::getValue('task');
            $this->smarty->assign('taskbar', $taskbar);
            $this->smarty->assign('checkconfig', $check);
            $html = $this->display(__FILE__, 'views/templates/admin/unlimitedproducttab.tpl');
            return $html.=$this->display(__FILE__, 'views/templates/admin/tabconfig.tpl');
        }
        $taskbar = 'addProductTab';
        $this->smarty->assign('taskbar', $taskbar);
        $html = $this->display(__FILE__, 'views/templates/admin/unlimitedproducttab.tpl');
        return $html . $this->createListTab();
    }

    public function createListTab()
    {
        $helper = new HelperList();
        $helper->simple_header = false;
        $helper->actions = array('edit', 'delete');
        $helper->toolbar_btn['new'] = array(
            'href' => AdminController::$currentIndex . '&configure='
         . $this->name . '&addNewTab&token=' . Tools::getAdminTokenLite('AdminModules'),
            'desc' => $this->l('Add new'));
        $helper->bulk_actions = array(
            'delete' => array(
                'text' => $this->l('Delete selected'),
                'icon' => 'icon-trash',
                'confirm' => $this->l('Delete selected items?')
            )
        );
        $helper->show_toolbar = true;
        $helper->shopLinkType = '';
        $helper->title = $this->l('tab list');
        $helper->identifier = 'id_tab';
        $helper->table = $this->name;
        $helper->list_id = $this->name;
        $helper->token = Tools::getAdminTokenLite('AdminModules');
        $helper->currentIndex = AdminController::$currentIndex.
        '&configure=' . $this->name . '&tab_list=configuration';
        $list = $this->searchAction($helper);
        $list_lang = $this->displayTitleLang($list);
        // echo"<pre>";
        // var_dump($list_lang);
        // die;
        $helper->listTotal = $this->totalList();
        $fields_list = array(
            'id_tab' => array(
                'title' => $this->l('Id'),
                'width' => 50,
                'type' => 'text',
                'align' => 'left id_tab'
            ),
            'tab_title' => array(
                'title' => $this->l('Tab Title'),
                'width' => 100,
                'type' => 'text',
                'align' => 'left tab title'
            ),
            'typetab' => array(
                'title' => $this->l('Type'),
                'width' => 100,
                'type' => 'text',
                'align' => 'left tab title'
            ),
            'tab_position' => array(
                'title' => $this->l('Tab Position'),
                'width' => 100,
                'type' => 'text',
                'align' => 'left tab title'
            ),
            'statustab' => array(
                'title' => $this->l('Status'),
                'width' => 100,
                'type' => 'bool',
                'active' => 'statustab',
                'align' => 'left status'
            ),
            'using_tab' => array(
                'title' => $this->l('Tab Using'),
                'width' => 100,
                'type' => 'text',
                'align' => 'left tab_using'
            ),
                /* 'content' => array(
                  'title' => $this->l('Content'),
                  'width' => 100,
                  'type' => 'text',
                  'align' => 'left content'
                  )*/
        );

        $html = $helper->generateList($list_lang, $fields_list);
        return $html;
    }
    public function displayTitleLang($list)
    {
        $id_default_language = (int) (Configuration::get('PS_LANG_DEFAULT'));
        $iso_default_language = Language::getIsoById($id_default_language);
        $arrList = array();
        $title_lang = array();
        foreach ($list as $value) {
            $title_lang = Tools::JsonDecode($value['tab_title'], true);
            $arrList[] = array (
                'id_tab'            =>$value['id_tab'],
                'tab_title'         =>$title_lang[$iso_default_language],
                'typetab'           =>$value['typetab'],
                'tab_position'      =>$value['tab_position'],
                'statustab'         =>$value['statustab'],
                'using_tab'         =>$value['using_tab'],
                'content'           =>$value['content'],
                'sizeframe_all'     =>$value['sizeframe_all']
            );
            
        }
        return $arrList;
    }
    public function totalList()
    {
        $db = DB::getInstance();
        $sql = 'SELECT COUNT(*)FROM ' . _DB_PREFIX_ . 'tabproducts';
        $sql.=$this->query;
        $row = $db->getValue($sql);
        return $row;
    }

    public function createForm()
    {
        $id =(int)Tools::getValue('id_tab');
        $db = DB::getInstance();
        
        if (empty($id)) {
            $message = $this->displayConfirmation($this->l('save successful'));
            if (Tools::isSubmit('unlimited-savestay-tab')) {
                $selecttype = Tools::getValue('selecttype');
                $data = $this->getValueForm($selecttype);
                $db->insert('tabproducts', $data);
                $sql = 'SELECT * FROM ' . _DB_PREFIX_ . 'tabproducts ORDER BY id_tab DESC';
                $row = $db->getRow($sql);
                return $message.=$this->getForm($row['id_tab']);
            }
            
            if (Tools::isSubmit('unlimited-save-tab')) {
                $selecttype = Tools::getValue('selecttype');
                $data = $this->getValueForm($selecttype);
                $db->insert('tabproducts', $data);
                return $message.=$this->displayList();
            }
            return $this->getForm($id);
        } else {
            $message = $this->displayConfirmation($this->l('update successful'));
            
            if (Tools::isSubmit('unlimited-savestay-tab')) {
                $selecttype = Tools::getValue('selecttype');
                $data = $this->getValueForm($selecttype);
                $db->update('tabproducts', $data, 'id_tab=' . $id);
                return $message.=$this->getForm($id);
            }
            
            if (Tools::isSubmit('unlimited-save-tab')) {
                $selecttype = Tools::getValue('selecttype');
                $data = $this->getValueForm($selecttype);
                $db->update('tabproducts', $data, 'id_tab=' . $id);
                return $message.=$this->displayList();
            }
            return $this->getForm($id);
        }
    }

    public function getForm($id_tab)
    {
        $gmaps = 'http://ajax.googleapis.com/ajax/libs/jqueryui/1.10.3/jquery-ui.min.js';
        $this->context->controller->addJS('http://maps.google.com/maps/api/js?sensor=false');
        $this->context->controller->addJS($gmaps);
        $this->context->controller->addJS($this->_path . 'views/js/jquery.ui.addresspicker.js');
        $check = '<script type="text/javascript" src="' . __PS_BASE_URI__ . 'js/tiny_mce/tiny_mce.js"></script>';
        
        $this->context->controller->addCSS($this->_path . 'views/css/demo.css');
        $this->context->controller->addCSS($this->_path . 'views/css/jquery.ui.all.css');
        $this->context->controller->addCSS($this->_path . 'views/css/datasheet.css');
        
        if (empty($id_tab)) {
            $this->smarty->assign('name', $this->name);
            $this->smarty->assign('token', Tools::getValue('token'));
            $html = $this->createEditer($check);
            return $html .= $this->display(__FILE__, 'views/templates/admin/createForm.tpl');
        } else {
            $db = DB::getInstance();
            $sql = 'SELECT * FROM ' . _DB_PREFIX_ . 'tabproducts WHERE id_tab = '.$id_tab;
            $row = $db->getRow($sql);
            $this->smarty->assign('id_tab', $id_tab);
            $this->smarty->assign('rowtitle', $row['tab_title']);
            $this->smarty->assign('rowtype', $row['typetab']);
            $this->smarty->assign('tabposition', $row['tab_position']);
            $this->smarty->assign('status', $row['statustab']);
            $this->smarty->assign('check_using_tab', $row['using_tab']);
            $this->smarty->assign('content', $row['content']);
            $this->smarty->assign('size', $row['sizeframe_all']);
            $this->smarty->assign('name', $this->name);
            $this->smarty->assign('token', Tools::getValue('token'));
            $html = $this->createEditer($check);
            return $html .= $this->display(__FILE__, 'views/templates/admin/editForm.tpl');
        }
    }

    public function getValueForm($selecttype)
    {
        $content = '';
        $size = '';
        $arryoutube = array();
        $title_lang = array();
        $arr_language = Language::getLanguages(false);
        $id_default_language = (int) (Configuration::get('PS_LANG_DEFAULT'));

        $iso_default_language = Language::getIsoById($id_default_language);
        foreach ($arr_language as $key => $value) {
            $checkdefault = Tools::getValue('tab_title_'.$iso_default_language);
            $checkTitle = Tools::getValue('tab_title_'.$value['iso_code']);
            if ($checkdefault == '') {
                if ($checkTitle != '') {
                    $title_lang[$value['iso_code']] = $checkTitle;
                } else {
                    $title_lang[$value['iso_code']] = $checkTitle;
                }
            } else {
                if ($checkTitle != '') {
                    $title_lang[$value['iso_code']] = $checkTitle;
                } else {
                    $title_lang[$value['iso_code']] = $checkdefault;
                }
            }
        }
        $title = Tools::jsonEncode($title_lang);
            // var_dump($title);
            // die;
        if ($selecttype == 'youtube') {
            $val = Tools::getValue('linkyoutube');
            $check = strpos($val, 'youtube.com');
            if ($check === false) {
                $content = $val;
            } else {
                $arr = parse_url($val);
                $query = $arr['query'];
                parse_str($query, $myArray);
                foreach ($myArray as $key => $array) {
                    if ($key=='v') {
                        $content = $array;
                    }
                }
            }
            $width = Tools::getValue('widthyoutube');
            $height = Tools::getValue('heightyoutube');
            $arryoutube['width'] = $width;
            $arryoutube['height'] = $height;
            $size = Tools::jsonEncode($arryoutube);
        }
        
        if ($selecttype == 'editor') {
            $arr_lang = array();
            foreach ($arr_language as $key => $value) {
                $checkdefault = Tools::getValue('editor_pdf_'.$iso_default_language);
                $check = Tools::getValue('editor_pdf_'.$value['iso_code']);
                if ($checkdefault == '') {
                    if ($check != '') {
                        $arr_lang[$value['iso_code']] = $check;
                    } else {
                        $arr_lang[$value['iso_code']] = $check;
                    }
                } else {
                    if ($check != '') {
                        $arr_lang[$value['iso_code']] = $check;
                    } else {
                        $arr_lang[$value['iso_code']] = $checkdefault;
                    }
                }
            }
                $arrstrig = Tools::jsonEncode($arr_lang);
                $content = $arrstrig;
                // var_dump($content);
            // die;
        }
        
        if ($selecttype=='maps') {
            $arrsize = array();
            $contentmaps = array();
            $content_lat = Tools::getValue('lat');
            $content_lng = Tools::getValue('lng');
            $contentmaps[] = $content_lat;
            $contentmaps[] = $content_lng;
            $content = Tools::jsonEncode($contentmaps);
            $width = Tools::getValue('widthmaps');
            $height = Tools::getValue('heightmaps');
            $arrsize['width'] = $width;
            $arrsize['height'] = $height;
            $size = Tools::jsonEncode($arrsize);
            //var_dump($size);die;
        }
        if ($selecttype == 'vimeo') {
            $arrvimeo = array();
            $content = Tools::getValue('linkvimeo');
            $width = Tools::getValue('widthvimeo');
            $height = Tools::getValue('heightvimeo');
            $arrvimeo['width'] = $width;
            $arrvimeo['height'] = $height;
            $size = Tools::jsonEncode($arrvimeo);
        }
        
        if ($selecttype == 'product') {
            $arrproduct = array();
            $arrproduct[] = Tools::getValue('selectproduct');
            $arrproduct[] = Tools::getValue('countproduct');
            $arrproduct[] = Tools::getValue('active_product');
            $arrproduct[] = Tools::getValue('manualID');
            $content = Tools::jsonEncode($arrproduct);
        }
            
        $sql=array(
            'tab_title'     => pSQL($title),
            'typetab'       => pSQL(Tools::getValue('selecttype')),
            'tab_position'  =>(int)Tools::getValue('tabposition'),
            'statustab'     =>(int)Tools::getValue('active'),
            'using_tab'     => pSQL(Tools::getValue('choose_using')),
            'content'       => pSQL($content, true),
            'sizeframe_all' => pSQL($size)
        );
        // echo "<pre>";
          // var_dump($sql);die;
        return $sql;
    }
    
    public function createEditer($check)
    {
        $iso = $this->context->language->iso_code;
        $this->context->controller->addJS(_PS_JS_DIR_ . 'admin/tinymce.inc.js');
        $this->context->controller->addJS($this->_path . 'views/js/tinymce.inc.js');
        $html = '
            <script type="text/javascript">    
                var iso = \'' .(file_exists(_PS_ROOT_DIR_ . '/js/tiny_mce/langs/' . $iso . '.js')? $iso : 'en'). '\' ;
                var pathCSS = \'' . _THEME_CSS_DIR_ . '\' ;
                var ad = \'' . dirname($_SERVER['PHP_SELF']). '\' ;
                var baseUrl = \'' . _PS_BASE_URL_ . __PS_BASE_URI__ . '\' ;
            </script>'
            .$check
            . '<script type="text/javascript" src="' . __PS_BASE_URI__ . 'js/admin/tinymce.inc.js"></script>
            <script language="javascript" type="text/javascript">
                id_language = Number(' . $this->context->language->id . ');
                tinySetup();
            </script>
        ';
        return $html;
    }

    public function deleteTab()
    {
        $db = DB::getInstance();
        $sql = 'DELETE FROM ' . _DB_PREFIX_ . 'tabproducts WHERE id_tab = ' .(int)Tools::getValue('id_tab');
        $db->execute($sql);
        return $this->createListTab();
    }

    public function deleteSelect()
    {
        $idArray = Tools::getValue('unlimitedproducttabBox');
        $idString = implode(",", $idArray);
        //var_dump($idString );die;
        Db::getInstance()->delete('tabproducts', "id_tab IN(" . pSQL($idString). ")");
        $url=AdminController::$currentIndex . '&token='.Tools::getAdminTokenLite('AdminModules')
        .'&configure=' . $this->name . '&module_name=' . $this->name;
        Tools::redirectAdmin($url);
    }

    public function searchAction($helper)
    {
        if (Tools::isSubmit('submitFilter')) {
            $id_tab = Tools::getValue($helper->list_id . 'Filter_id_tab');
            $tab_title = Tools::getValue($helper->list_id . 'Filter_tab_title');
            $type = Tools::getValue($helper->list_id . 'Filter_typetab');
            $position = Tools::getValue($helper->list_id . 'Filter_tab_position');
            $status = Tools::getValue($helper->list_id . 'Filter_statustab');
            $using_tab = Tools::getValue($helper->list_id . 'Filter_using_tab');
            $content = Tools::getValue($helper->list_id . 'Filter_content');
            $this->context->cookie->{$helper->list_id . 'Filter_id_tab'}= $id_tab;
            $this->context->cookie->{$helper->list_id . 'Filter_tab_title'}= $tab_title;
            $this->context->cookie->{$helper->list_id . 'Filter_typetab'}= $type;
            $this->context->cookie->{$helper->list_id . 'Filter_tab_position'}= $position;
            $this->context->cookie->{$helper->list_id . 'Filter_statustab'}= $status;
            $this->context->cookie->{$helper->list_id . 'Filter_using_tab'}= $using_tab;
            $this->context->cookie->{$helper->list_id . 'Filter_content'}= $content;
        }
        
        if (Tools::isSubmit('submitReset' . $helper->list_id)) {
            $this->context->cookie->{$helper->list_id . 'Filter_id_tab'}= null;
            $this->context->cookie->{$helper->list_id . 'Filter_tab_title'}= null;
            $this->context->cookie->{$helper->list_id . 'Filter_typetab'}= null;
            $this->context->cookie->{$helper->list_id . 'Filter_tab_position'}= null;
            $this->context->cookie->{$helper->list_id . 'Filter_statustab'}= null;
            $this->context->cookie->{$helper->list_id . 'Filter_using_tab'}= null;
            $this->context->cookie->{$helper->list_id . 'Filter_content'}= null;
        }
        return $this->getListSearch($helper);
    }

    public function getListSearch($helper)
    {
        $db = DB::getInstance();
        $orderby = pSQL(Tools::getValue($helper->list_id . "Orderby", "tab_position"));
        $orderway = pSQL(Tools::getValue($helper->list_id . "Orderway", "ASC"));
        $cookiePagination = $this->context->cookie->{$helper->list_id . '_pagination'};
        $selected_pagination =(int)Tools::getValue($helper->list_id . '_pagination', $cookiePagination);
        if ($selected_pagination <= 0) {
            $selected_pagination = 20;
        }
        $this->context->cookie->{$helper->list_id . '_pagination'}= $selected_pagination;// get Selected Page number
        $page =(int)Tools::getValue('submitFilter' . $helper->list_id);
        if (!$page) {
            $page = 1;
        }
        $start =($page - 1 )* $selected_pagination;
        $sqlquery = array();
        $id_tab = (int)$this->context->cookie->{$helper->list_id . 'Filter_id_tab'};
        $title = pSQL($this->context->cookie->{$helper->list_id . 'Filter_tab_title'}). '%"';
        $type = pSQL($this->context->cookie->{$helper->list_id . 'Filter_typetab'}). '%"';
        $position = (int)$this->context->cookie->{$helper->list_id . 'Filter_tab_position'};
        $status = (int)$this->context->cookie->{$helper->list_id . 'Filter_statustab'};
        $using_tab = pSQL($this->context->cookie->{$helper->list_id . 'Filter_using_tab'}). '%"';
        $content = pSQL($this->context->cookie->{$helper->list_id . 'Filter_content'}). '%"';
        if ($this->context->cookie->{$helper->list_id . 'Filter_id_tab'}!= '') {
            $sqlquery[] = ' id_tab = ' . $id_tab;
        }
        
        if ($this->context->cookie->{$helper->list_id . 'Filter_tab_title'}!= '') {
            $sqlquery[] = ' tab_title LIKE "%' .$title ;
        }
        
        if ($this->context->cookie->{$helper->list_id . 'Filter_typetab'}!= '') {
            $sqlquery[] = ' typetab LIKE "%' .$type ;
        }
        
        if ($this->context->cookie->{$helper->list_id . 'Filter_tab_position'}!= '') {
            $sqlquery[] = ' tab_position = ' .$position;
        }
        
        if ($this->context->cookie->{$helper->list_id . 'Filter_statustab'}!= '') {
            $sqlquery[] = ' statustab = ' .$status;
        }
        
        if ($this->context->cookie->{$helper->list_id . 'Filter_using_tab'}!= '') {
            $sqlquery[] = ' using_tab LIKE "%' .$using_tab;
        }
        
        if ($this->context->cookie->{$helper->list_id . 'Filter_content'}!= '') {
            $sqlquery[] = ' content LIKE "%' .$content;
        }
        $strquery = implode(' AND ', $sqlquery);
        //var_dump($strquery);die;
        $sql = 'SELECT * FROM ' . _DB_PREFIX_ . 'tabproducts';
        if ($strquery == '') {
            $sql.=' ORDER BY ' . $orderby . ' ' . $orderway . ' LIMIT ' . $start . ', ' . $selected_pagination;
            $rows = $db->ExecuteS($sql);
            return $rows;
        } else {
            $this->query = ' WHERE ' . $strquery;
            $sql.=' WHERE ' . $strquery . '
         ORDER BY ' . $orderby . ' ' . $orderway . '
         LIMIT ' . $start . ', ' . $selected_pagination;
            $rows = $db->ExecuteS($sql);
            return $rows;
        }
    }

    public function createTable()
    {
        $db = Db::getInstance();
        $sql = 'CREATE TABLE IF NOT EXISTS ' . _DB_PREFIX_ . 'tabproducts(id_tab INT(6)'
                . 'UNSIGNED AUTO_INCREMENT PRIMARY KEY,'
                . 'tab_title varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci,'
                . 'typetab varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci,tab_position INT(3),'
                . 'statustab INT(1),using_tab  varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci,'
                . 'content text CHARACTER SET utf8 COLLATE utf8_unicode_ci,'
                . 'sizeframe_all varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci)';


        $sqltb2 = 'CREATE TABLE IF NOT EXISTS '
        . _DB_PREFIX_ . 'product_tab(id_product INT(5),id_tab INT(5),'
        . 'PRIMARY KEY(id_product,id_tab),content_tab text CHARACTER SET utf8 COLLATE utf8_unicode_ci,'
        . 'sizeframe varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci ,display int(1))';

        $sql_lang = 'CREATE TABLE IF NOT EXISTS '
        . _DB_PREFIX_ . 'producttab_lang(id_tab INT(5),id_lang INT(5),'
        . 'PRIMARY KEY(id_tab,id_lang),iso_code varchar(30),title_lang varchar(255) '
        . 'CHARACTER SET utf8 COLLATE utf8_unicode_ci,content_lang text CHARACTER SET utf8 COLLATE utf8_unicode_ci)';
        
        
        $db->query($sql);
        $db->query($sqltb2);
        $db->query($sql_lang);
        return true;
    }
    
    public function dropTable()
    {
        $db = Db::getInstance();
        $sql = 'DROP TABLE ' ._DB_PREFIX_. 'tabproducts';
        $sql1 = 'DROP TABLE ' ._DB_PREFIX_. 'product_tab';
        $sql_lang = 'DROP TABLE ' . _DB_PREFIX_. 'producttab_lang';
        $db->execute($sql_lang);
        $db->execute($sql);
        $db->execute($sql1);
    }
}
