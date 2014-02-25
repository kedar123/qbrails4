# -*- coding: utf-8 -*-
##############################################################################
#
#    OpenERP, Open Source Management Solution
#    Copyright (C) 2004-2010 Tiny SPRL (<http://tiny.be>).
#
#    This program is free software: you can redistribute it and/or modify
#    it under the terms of the GNU Affero General Public License as
#    published by the Free Software Foundation, either version 3 of the
#    License, or (at your option) any later version.
#
#    This program is distributed in the hope that it will be useful,
#    but WITHOUT ANY WARRANTY; without even the implied warranty of
#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#    GNU Affero General Public License for more details.
#
#    You should have received a copy of the GNU Affero General Public License
#    along with this program.  If not, see <http://www.gnu.org/licenses/>.
#
##############################################################################

import time
from datetime import datetime
from dateutil.relativedelta import relativedelta

import netsvc
from osv import fields, osv
from tools.translate import _
from decimal import Decimal
#from babel.dates import field

class account_invoice_line(osv.osv):
    
    _inherit = "account.invoice.line"
    _columns = {
                
               'tax_id_q' :fields.many2one('account.tax', 'tax_id', ondelete='set null'),
                
                }
    
account_invoice_line()

class account_invoice(osv.osv):
    
    _inherit = "account.invoice"
    _columns = {
                
               'transaction_id' :fields.char('transaction_id', size=64)
                
                }
    
account_invoice()

class account_voucher(osv.osv):
    _inherit = "account.voucher"
    _columns = {
                
               'transaction_id' :fields.char('transaction_id', size=64),
               'type':fields.selection([
                                        ('sale','Sale'),
                                        ('purchase','Purchase'),
                                        ('payment','Payment'),
                                        ('receipt','Receipt'),
                                        ('billpaymentcheck','BillPaymentCheck'),
                                        ('transfer','Transfer'),
                                        ('receivepayment','ReceivePayment'),
                                        ('bill','Bill'),
                                        ('purchaseorder','PurchaseOrder'),
                                        ('billpaymentcheck','BillPaymentCheck'),
                                        ('invoice','Invoice'),
                                        ('receivepayment','ReceivePayment'),
                                        ('buildassembly','BuildAssembly'),
                                        ('salesorder','SalesOrder'),
                                        ('paycheck','Paycheck'),
                                        ('creditcardcharge','CreditCardCharge'),
                                        ('salestaxpaymentcheck','SalesTaxPaymentCheck'),
                                        ('deposit','Deposit'),
                                        ('estimate','Estimate'),
                                        ('vendorcredit','VendorCredit'),
                                        ('salesreceipt','SalesReceipt'),
                                        ('check','Check'),
                                        ('payrollliabilitycheck','PayrollLiabilityCheck'),
                                        ('inventoryadjustment','InventoryAdjustment'),
                                        ('itemreceipt','ItemReceipt'),
                                        ('creditmemo','CreditMemo'),
                                        ('journalentry','JournalEntry') ],'Default Type', readonly=True, states={'draft':[('readonly',False)]}),
                                        
                
                }
    
account_voucher()


class account_invoice_line(osv.osv):
    """ Company Discount and Cashboxes """
    _inherit = 'account.invoice.line'

    _columns = {
        'quick_book_tax_id': fields.many2one('account.tax', 'Tax Quick'),    }

account_invoice_line()

class product_product(osv.osv):
	_inherit = "product.product"

	_columns = {
			'quick_product_account_id':fields.many2one("account.account", 'Quickbook Account'),
#            'quickbook_id':fields.char("Quickbook ID",size=50),
			
		}
	def create(self, cr, uid, values, context=None):
		print "\n\n kedarrrrrrrrrrrrrr ===========>>>>>>>>>",values
		res = super(product_product,self).create(cr, uid, values, context=context)
		return res
product_product()

class product_template(osv.osv):
    _inherit= "product.template"
    _columns={
              'quickbook_id':fields.char("Quickbook ID",size=50),
              'quickbook_time':fields.datetime('Date & Time'),
              
              }
product_template()
    
product_template()
class res_partner(osv.osv):
    _inherit = "res.partner"
    
    _columns ={
               'quick_list_number' : fields.char("Quickbook ID",size=50),
               'quickbook_time':fields.datetime('Date & Time'),
               }
res_partner()


class account_tax(osv.osv):
    _inherit="account.tax"
    
    _columns={
              'quickbook_id':fields.char("Quickbook ID",size=50),
              'quickbook_time':fields.datetime('Date & Time'),
              
              }
account_tax()


class resource_resource(osv.osv):
    _inherit="resource.resource"
    
    _columns={
              'quickbook_id':fields.char("Quickbook ID",size=50),
              'quickbook_time':fields.datetime('Date & Time'),
              }
resource_resource()

class account_account(osv.osv):
    _inherit="account.account"
    
    _columns={
              'quickbook_id':fields.char("Quickbook ID",size=50),
              'quickbook_time':fields.datetime('Date & Time'),
              
              }
account_account()