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



package com.adobe.webapis.ebay.results
{
	import com.adobe.webapis.ebay.objects.*;
	

	/**
	 * Contains the results from a GetItem API call.
	 * 
	 * <p>Extends EBayResult class, inheriting standard output fields.</p>
	 * 
	 * <p>Contains the following additional objects:
	 * 	<ul>
	 * 		<li><code>BestOfferDetails</code></li>
	 * 		<li><code>BuyerRequirements</code></li>
	 * 		<li><code>Category</code></li>
	 * 		<li><code>Charity</code></li>
	 * 		<li><code>ContactDetails</code></li>
	 * 		<li><code>CrossPromotion</code></li>
	 * 		<li><code>DigitalDeliveryDetails</code></li>
	 * 		<li><code>EBayUser</code></li>
	 * 		<li><code>ListingCheckoutRedirectPreference</code></li>
	 * 		<li><code>ListingDesigner</code></li>
	 * 		<li><code>ListingDetails</code></li>
	 * 		<li><code>PaymentDetails</code></li>
	 * 		<li><code>PictureDetails</code></li>
	 * 		<li><code>ProductListingDetails</code></li>
	 * 		<li><code>ReviseStatus</code></li>
	 * 		<li><code>SellingStatus</code></li>
	 * 		<li><code>ShippingDetails</code></li>
	 * 		<li><code>StoreFront</code></li>
	 * 		<li><code>VATDetails</code></li>
	 * 	</ul>
	 * </p>
	 * 
	 * @langversion ActionScript 3.0
	 * @playerversion Flash 9
	 * @tiptext
	 * 
	 * @author Charles Bihis, Adobe Systems Incorporated
	 * 
	 * @see com.adobe.webapis.ebay.EBayService#getItem()
	 * @see com.adobe.webapis.ebay.results.EBayResult
	 * 
	 * @see com.adobe.webapis.ebay.objects.BestOfferDetails
	 * @see com.adobe.webapis.ebay.objects.BuyerRequirements
	 * @see com.adobe.webapis.ebay.objects.Category
	 * @see com.adobe.webapis.ebay.objects.Charity
	 * @see com.adobe.webapis.ebay.objects.ContactDetails
	 * @see com.adobe.webapis.ebay.objects.CrossPromotion
	 * @see com.adobe.webapis.ebay.objects.DigitalDeliveryDetails
	 * @see com.adobe.webapis.ebay.results.EBayUser
	 * @see com.adobe.webapis.ebay.objects.ListingCheckoutRedirectPreference
	 * @see com.adobe.webapis.ebay.objects.ListingDesigner
	 * @see com.adobe.webapis.ebay.objects.ListingDetails
	 * @see com.adobe.webapis.ebay.objects.PaymentDetails
	 * @see com.adobe.webapis.ebay.objects.PictureDetails
	 * @see com.adobe.webapis.ebay.objects.ProductListingDetails
	 * @see com.adobe.webapis.ebay.objects.ReviseStatus
	 * @see com.adobe.webapis.ebay.objects.SellingStatus
	 * @see com.adobe.webapis.ebay.objects.ShippingDetails
	 * @see com.adobe.webapis.ebay.objects.StoreFront
	 * @see com.adobe.webapis.ebay.objects.VATDetails
	 */	
	public class EBayItem extends EBayResult
	{
		public var applicationData:String;
		public var autoPay:Boolean;
		public var bestOfferDetails:BestOfferDetails;
		public var buyerProtection:String;
		public var buyerRequirements:BuyerRequirements;
		public var buyerResponsibleForShipping:Boolean;
		public var buyItNowPrice:Number;
		public var charity:Charity;
		public var country:String;
		public var crossPromotion:CrossPromotion;
		public var currency:String;
		public var description:String;
		public var digitalDeliveryDetails:DigitalDeliveryDetails;
		public var disableBuyerRequirements:Boolean;
		public var dispatchTimeMax:int;
		public var financeOfferID:String;
		public var freeAddedCategory:Category;
		public var getItFast:Boolean;
		public var giftIcon:int;
		[ArrayElementType("String")]
		public var giftServices:Array;
		public var hitCount:Number;
		public var hitCounter:String;
		public var itemID:String;
		public var listingCheckoutRedirectPreference:ListingCheckoutRedirectPreference;
		public var listingDesigner:ListingDesigner;
		public var listingDetails:ListingDetails;
		public var listingDuration:String;
		[ArrayElementType("String")]
		public var listingEnhancement:Array;
		public var listingSubtype:String;
		public var listingType:String;
		public var location:String;
		public var locationDefaulted:Boolean;
		public var lotSize:int;
		public var motorsGermanySearchable:Boolean;
		public var nowAndNew:Boolean;
		public var paymentDetails:PaymentDetails;
		[ArrayElementType("String")]
		public var paymentMethods:Array;
		public var payPalEmailAddress:String;
		public var pictureDetails:PictureDetails;
		public var postalCode:String;
		public var primaryCategory:Category;
		public var privateListing:Boolean;
		public var productListingDetails:ProductListingDetails;
		public var proxyItem:Boolean;
		public var quantity:int;
		public var regionID:String;
		public var relisted:Boolean;
		public var relistLink:Boolean;
		public var reservePrice:Number;
		public var reviseStatus:ReviseStatus;
		public var secondaryCategory:Category;
		public var seller:EBayUser;
		public var sellerContactDetails:ContactDetails;
		public var sellerInventoryID:String;
		public var sellerVacationNote:String;
		public var sellingStatus:SellingStatus;
		public var shippingDetails:ShippingDetails;
		public var shippingTermsInDescription:Boolean;
		[ArrayElementType("String")]
		public var shipToLocations:Array;
		public var site:String;
		public var sku:String;
		[ArrayElementType("String")]
		public var skypeContactOption:Array;
		public var skypeEnabled:Boolean;
		public var skypeID:String;
		public var startPrice:Number;
		public var storeFront:StoreFront;
		public var subTitle:String;
		public var thirdPartyCheckout:Boolean;
		public var thirdPartyCheckoutIntegration:Boolean;
		public var timeLeft:String;
		public var title:String;
		public var uuID:String;
		public var vatDetails:VATDetails;
		public var watchCount:Number;
		

		/**
		 * Constructor for the EBayItem class.
		 * 
		 * <p>Creates a new EbayItem object.</p>
		 */
		public function EBayItem()
		{
			this.giftServices = new Array();
			this.listingEnhancement = new Array();
			this.paymentMethods = new Array();
			this.shipToLocations = new Array();
			this.skypeContactOption = new Array();
		}  // EBayItem
	}  // class declaration
}  // package