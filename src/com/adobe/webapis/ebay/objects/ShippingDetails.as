/*
Adobe Systems Incorporated(r) Source Code License Agreement
Copyright(c) 2006 Adobe Systems Incorporated. All rights reserved.
	
Please read this Source Code License Agreement carefully before using
the source code.
	
Adobe Systems Incorporated grants to you a perpetual, worldwide, non-exclusive,
no-charge, royalty-free, irrevocable copyright license, to reproduce,
prepare derivative works of, publicly display, publicly perform, and
distribute this source code and such derivative works in source or
object code form without any attribution requirements.
	
The name "Adobe Systems Incorporated" must not be used to endorse or promote products
derived from the source code without prior written permission.
	
You agree to indemnify, hold harmless and defend Adobe Systems Incorporated from and
against any loss, damage, claims or lawsuits, including attorney's
fees that arise or result from your use or distribution of the source
code.
	
THIS SOURCE CODE IS PROVIDED "AS IS" AND "WITH ALL FAULTS", WITHOUT
ANY TECHNICAL SUPPORT OR ANY EXPRESSED OR IMPLIED WARRANTIES, INCLUDING,
BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS
FOR A PARTICULAR PURPOSE ARE DISCLAIMED. ALSO, THERE IS NO WARRANTY OF
NON-INFRINGEMENT, TITLE OR QUIET ENJOYMENT. IN NO EVENT SHALL MACROMEDIA
OR ITS SUPPLIERS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,
EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS;
OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,
WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR
OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOURCE CODE, EVEN IF
ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
*/



package com.adobe.webapis.ebay.objects
{
	/**
	 * The shipping-related details for an item or transaction, including
	 * flat and calculated shipping costs and shipping insurance costs.
	 * 
	 * <p>Contains the following additional objects:
	 * 	<ul>
	 *		<li><code>CalculatedShippingRate</code></li>
	 * 		<li><code>InsuranceDetails</code></li>
	 * 		<li><code>ShippingServiceOption</code></li>
	 * 		<li><code>SalesTax</code></li>
	 * 		<li><code>TaxTable</code></li>
	 * 	</ul>
	 * </p>
	 * 
	 * @langversion ActionScript 3.0
	 * @playerversion Flash 9
	 * @tiptext
	 * 
	 * @author Charles Bihis, Adobe Systems Incorporated
	 * 
	 * @see com.adobe.webapis.ebay.objects.CalculatedShippingRate
	 * @see com.adobe.webapis.ebay.objects.InsuranceDetails
	 * @see com.adobe.webapis.ebay.objects.ShippingServiceOption
	 * @see com.adobe.webapis.ebay.objects.SalesTax
	 * @see com.adobe.webapis.ebay.objects.TaxTable
	 */
	public class ShippingDetails
	{
		public var applyShippingDiscount:Boolean;
		public var calculatedShippingRate:CalculatedShippingRate;	
		public var defaultShippingCost:Number;
		public var getItFast:Boolean;
		public var insuranceDetails:InsuranceDetails;
		public var insuranceFee:Number;
		public var insuranceOption:String;
		public var internationalInsuranceDetails:InsuranceDetails;
		[ArrayElementType("ShippingServiceOption")]
		public var internationalShippingServiceOption:Array;
		public var paymentInstructions:String;
		public var salesTax:SalesTax;
		public var sellingManagerSalesRecordNumber:int;
		public var shippingRateType:String;
		[ArrayElementType("ShippingServiceOption")]
		public var shippingServiceOptions:Array;
		public var shippingType:String;
		public var taxTable:TaxTable;
		public var thirdPartyCheckout:Boolean;

		
		public function ShippingDetails()
		{
			this.internationalShippingServiceOption = new Array();
			this.shippingServiceOptions = new Array();
		}  // ShippingDetails
	}  // class declaration
}  // package