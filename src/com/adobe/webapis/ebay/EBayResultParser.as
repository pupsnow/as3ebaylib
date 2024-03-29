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

package com.adobe.webapis.ebay
{
	import com.adobe.webapis.ebay.AuthAndAuth;
	import com.adobe.webapis.ebay.results.*;
	import com.adobe.webapis.ebay.objects.*;
	
	/** 
	 * Use the EBay internal namespace for parsing server results since some
	 * of the package internal methods use the ebay_internal methods
	 */
	use namespace ebay_internal;
	
	/**
	 * Class that contains internal helper functions used to parse
	 * the XML returned from the eBay servers to create the relevant
	 * objects.
	 * 
	 * Only meant as helpers for the library; NOT meant for use by
	 * developers using the library.
	 * 
	 * @langversion ActionScript 3.0
	 * @playerversion Flash 9
	 * @tiptext
	 * 
	 * @author Charles Bihis, Adobe Systems Incorporated
	 */
	public final class EBayResultParser
	{
		default xml namespace = new Namespace(AuthAndAuth.NAMESPACE);


		/**
		 * Creates an AddOrRemoveFromWatchListResult object.
		 * 
		 * @param resultData The XML relevant to the AddOrRemoveFromWatchListResult object
		 * @return A new AddOrRemoveFromWatchListResult object
		 */
		ebay_internal static function parseAddOrRemoveFromWatchListResult(resultData:XML):AddOrRemoveFromWatchListResult
		{
			var callResult:AddOrRemoveFromWatchListResult = new AddOrRemoveFromWatchListResult();

			parseStandardFields(resultData, callResult);
			
			if (callResult.ack != "Success" && callResult.ack != "Warning")
				return callResult;

			callResult.watchListCount = int(resultData.WatchListCount);
			callResult.watchListMaximum = int(resultData.WatchListMaximum);

			return callResult;
		}  // parseAddOrRemoveFromWatchListResult


		/**
		 * Creates an Address object.
		 * 
		 * @param addressData The XML relevant to the Address object
		 * @return A new Address object
		 */
		internal static function parseAddress(addressData:XMLList):Address
		{
			var address:Address = new Address();

			address.cityName = addressData.CityName;
			address.country = addressData.Country;
			address.countryName = addressData.CountryName;
			address.name = addressData.Name;
			address.phone = addressData.Phone;
			address.postalCode = addressData.PostalCode;
			address.stateOrProvince = addressData.StateOrProvince;
			address.street = addressData.Street;
			address.street1 = addressData.Street1;
			address.street2 = addressData.Street2;

			return address;
		}  // parseAddress


		/**
		 * Creates a BestOfferDetails object.
		 * 
		 * @param detailsData The XML relevant to the BestOfferDetails object
		 * @return A new BestOfferDetails object
		 */
		internal static function parseBestOfferDetails(detailsData:XMLList):BestOfferDetails
		{
			var bestOfferDetails:BestOfferDetails = new BestOfferDetails();

			bestOfferDetails.bestOfferCount = int(detailsData.BestOfferCount);
			bestOfferDetails.bestOfferEnabled = detailsData.BestOfferEnabled == "true" ? true : false;

			return bestOfferDetails;
		}  // parseBestOfferDetails
		

		/**
		 * Creates a BiddingDetails object.
		 * 
		 * @param detailsData The XML relevant to the BiddingDetails object
		 * @return A new BiddingDetails object.
		 */
		internal static function parseBiddingDetails(detailsData:XMLList):BiddingDetails
		{
			var biddingDetails:BiddingDetails = new BiddingDetails();

			biddingDetails.convertedMaxBid = Number(detailsData.ConvertedMaxBid);
			biddingDetails.maxBid = Number(detailsData.MaxBid);
			biddingDetails.quantityBid = int(detailsData.QuantityBid);
			biddingDetails.quantityWon = int(detailsData.QuantityWon);

			return biddingDetails;
		}  // parseBiddingDetails


		/**
		 * Creates a BidList object.
		 * 
		 * @param listData The XML relevant to the BidList object
		 * @return A new BidList object
		 */
		internal static function parseBidList(listData:XMLList):BidList
		{
			var bidList:BidList = new BidList();

			for each (var bidListNode:XML in listData.ItemArray.Item)
				bidList.bidListItem.push(parseBidListItem(XMLList(bidListNode)));
			bidList.paginationResult = parsePaginationResult(listData.PaginationResult);

			return bidList;
		}  // parseBidList


		/**
		 * Creates a BidListItem object.
		 * 
		 * @param itemData The XML relevant to the BidListItem object
		 * @return A new BidListItem object
		 */
		internal static function parseBidListItem(itemData:XMLList):BidListItem
		{
			var bidListItem:BidListItem = new BidListItem();

			bidListItem.biddingDetails = parseBiddingDetails(itemData.BiddingDetails);
			bidListItem.eBayNotes = itemData.eBayNotes;
			bidListItem.itemID = itemData.ItemID;
			bidListItem.listingDetails = parseListingDetails(itemData.ListingDetails);
			bidListItem.listingType = itemData.ListingType;
			bidListItem.pictureDetails = parsePictureDetails(itemData.PictureDetails);
			bidListItem.quantityAvailable = int(itemData.QuantityAvailable);
			bidListItem.seller = parseSellerInfo(itemData.Seller);
			bidListItem.sellingStatus = parseSellingStatus(itemData.SellingStatus);
			bidListItem.shippingDetails = parseShippingDetails(itemData.ShippingDetails);
			bidListItem.site = itemData.Site;
			bidListItem.startPrice = Number(itemData.StartPrice);
			bidListItem.timeLeft = itemData.TimeLeft;
			bidListItem.title = itemData.Title;

			return bidListItem;
		}  // parseBidListItem


		/**
		 * Creates a BuyerInfo object.
		 * 
		 * @param infoData The XML relevant to the BuyerInfo object
		 * @return A new BuyerInfo object
		 */
		internal static function parseBuyerInfo(infoData:XMLList):BuyerInfo
		{
			var buyerInfo:BuyerInfo = new BuyerInfo();

			buyerInfo.shippingAddress = parseAddress(infoData.ShippingAddress);

			return buyerInfo;
		}  // parseBuyerInfo


		/**
		 * Creates a BuyerRequirements object.
		 * 
		 * @param requirementsData The XML relevant to the BuyerRequirements object
		 * @return A new BuyerRequirements object
		 */
		internal static function parseBuyerRequirements(requirementsData:XMLList):BuyerRequirements
		{
			var buyerRequirements:BuyerRequirements = new BuyerRequirements();

			buyerRequirements.linkedPayPalAccount = requirementsData.LinkedPayPalAccount == "true" ? true : false;
			buyerRequirements.maximumItemRequirements = parseMaximumItemRequirements(requirementsData.MaximumItemRequirements);
			buyerRequirements.maximumUnpaidItemStrikes = requirementsData.MaximumUnpaidItemStrikes == "true" ? true : false;
			buyerRequirements.minimumFeedbackScore = int(requirementsData.MinimumFeedbackScore);
			buyerRequirements.shipToRegistrationCountry = requirementsData.ShipToRegistrationCountry == "true" ? true : false;
			buyerRequirements.verifiedUserRequirements = parseVerifiedUserRequirements(requirementsData.VerifiedUserRequirements);
			buyerRequirements.zeroFeedbackScore = requirementsData.ZeroFeedbackScore == "true" ? true : false;

			return buyerRequirements;
		}  // parseBuyerRequirements


		/**
		 * Creates a BuyingSummary object.
		 * 
		 * @param summaryData The XML relevant to the BuyingSummary object
		 * @return A new BuyingSummary object
		 */
		internal static function parseBuyingSummary(summaryData:XMLList):BuyingSummary
		{
			var buyingSummary:BuyingSummary = new BuyingSummary();

			buyingSummary.bestOfferCount = int(summaryData.BestOfferCount);
			buyingSummary.biddingCount = int(summaryData.BiddingCount);
			buyingSummary.totalWinningCost = Number(summaryData.TotalWinningCost);
			buyingSummary.totalWonCost = Number(summaryData.TotalWonCost);
			buyingSummary.winningCount = int(summaryData.WinningCount);
			buyingSummary.wonCount = int(summaryData.WinningCount);
			buyingSummary.wonDurationInDays = int(summaryData.WonDurationInDays);

			return buyingSummary;
		}  // parseBuyingSummary


		/**
		 * Creates a CalculatedShippingRate object.
		 * 
		 * @param rateDetails The XML relevant to the CalculatedShippingRate object
		 * @return A new CalculatedShippingRate object
		 */
		internal static function parseCalculatedShippingRate(rateDetails:XMLList):CalculatedShippingRate
		{
			var calculatedShippingRate:CalculatedShippingRate = new CalculatedShippingRate();

			calculatedShippingRate.internationPackagingHandlingCosts = Number(rateDetails.InternationalPackagingHandlingCosts);
			calculatedShippingRate.originatingPostalCode = rateDetails.OriginatingPostalCode;
			calculatedShippingRate.packageDepth = Number(rateDetails.PackageDepth);
			calculatedShippingRate.packageLength = Number(rateDetails.PackageLength);
			calculatedShippingRate.packageWidth = Number(rateDetails.PackageWidth);
			calculatedShippingRate.packagingHandlingCosts = Number(rateDetails.PackagingHandlingCosts);
			calculatedShippingRate.shippingIrregular = rateDetails.ShippingIrregular == "true" ? true : false;
			calculatedShippingRate.shippingPackage = rateDetails.ShippingPackage;
			calculatedShippingRate.weightMajor = Number(rateDetails.WeightMajor);
			calculatedShippingRate.weightMinor = Number(rateDetails.WeightMinor);

			return calculatedShippingRate;
		}  // parseCalculatedShippingRate


		/**
		 * Creates a Category object.
		 * 
		 * @param categoryDetails The XML relevant to the Category object
		 * @return A new Category object
		 */
		internal static function parseCategory(categoryDetails:XMLList):Category
		{
			var category:Category = new Category();

			category.categoryID = categoryDetails.CategoryID;
			category.categoryName = categoryDetails.CategoryName;

			return category;
		}  // parseCategory


		/**
		 * Creates a Charity object.
		 * 
		 * @param charityData The XML relevant to the Charity object
		 * @return A new Charity object
		 */
		internal static function parseCharity(charityData:XMLList):Charity
		{
			var charity:Charity = new Charity();

			charity.charityID = charityData.CharityID;
			charity.charityName = charityData.CharityName;
			charity.charityNumber = int(charityData.CharityNumber);
			charity.donationPercent = Number(charityData.DonationPercent);
			charity.logoURL = charityData.LogoURL;
			charity.status = charityData.Status;

			return charity;
		}  // parseCharity


		/**
		 * Creates a ContactDetails object.
		 * 
		 * @param detailsData The XML relevant to the ContactDetails object
		 * @return A new ContactDetails object
		 */
		internal static function parseContactDetails(detailsData:XMLList):ContactDetails
		{
			var contactDetails:ContactDetails = new ContactDetails();

			contactDetails.cityName = detailsData.CityName;
			contactDetails.companyName = detailsData.CompanyName;
			contactDetails.country = detailsData.Country;
			contactDetails.phone2AreaOrCityCode = detailsData.Phone2AreaOrCityCode;
			contactDetails.phone2CountryCode = detailsData.Phone2CountryCode;
			contactDetails.phone2CountryPrefix = detailsData.Phone2CountryPrefix;
			contactDetails.phone2LocalNumber = detailsData.Phone2LocalNumber;
			contactDetails.phoneAreaOrCityCode = detailsData.PhoneAreaOrCityCode;
			contactDetails.phoneCountryCode = detailsData.PhoneCountryCode;
			contactDetails.phoneCountryPrefix = detailsData.PhoneCountryPrefix;
			contactDetails.phoneLocalNumber = detailsData.PhoneLocalNumber;
			contactDetails.stateOrProvince = detailsData.StateOrProvince;
			contactDetails.street1 = detailsData.Street1;
			contactDetails.street2 = detailsData.Street2;

			return contactDetails;
		}  // parseContactDetails


		/**
		 * Creates a CrossPromotion object.
		 * 
		 * @param promotionData The XML relevant to the CrossPromotion object
		 * @return A new CrossPromotion object
		 */
		internal static function parseCrossPromotion(promotionData:XMLList):CrossPromotion
		{
			var crossPromotion:CrossPromotion = new CrossPromotion();

			crossPromotion.itemID = promotionData.ItemID;
			crossPromotion.primaryScheme = promotionData.PrimaryScheme;
			for each (var itemNode:XML in promotionData.PromotedItem)
				crossPromotion.promotedItem.push(parsePromotedItem(XMLList(itemNode)));
			crossPromotion.promotionMethod = promotionData.PromotionMethod;
			crossPromotion.sellerID = promotionData.SellerID;
			crossPromotion.sellerKey = promotionData.SellerKey;
			crossPromotion.shippingDiscount = promotionData.ShippingDiscount == "true" ? true : false;
			crossPromotion.storeName = promotionData.StoreName;

			return crossPromotion;
		}  // parseCrossPromotion


		/**
		 * Creates a Date object.
		 * 
		 * @param dateString The date string in the proper format to create the new Date object
		 * @return A new Date object
		 */
		internal static function parseDateString(dateString:String):Date 
		{
			return new Date(dateString.substr(0, 4),  			// year
							int(dateString.substr(5, 2)) - 1, 	// month
							dateString.substr(8, 2),  			// date
							dateString.substr(11, 2), 			// hour
							dateString.substr(14, 2), 			// minute
							dateString.substr(17, 2), 			// second
							dateString.substr(20, 3));			// millisecond
		}  // parseDateString


		/**
		 * Creates a DigitalDeliveryDetails object.
		 * 
		 * @param detailsData The XML relevant to the DigitalDeliveryDetails object
		 * @return A new DigitalDeliveryDetails object
		 */
		internal static function parseDigitalDeliveryDetails(detailsData:XMLList):DigitalDeliveryDetails
		{
			var deliveryDetails:DigitalDeliveryDetails = new DigitalDeliveryDetails();

			deliveryDetails.instructions = detailsData.Instructions;
			deliveryDetails.method = detailsData.Method;
			deliveryDetails.requirements = detailsData.Requirements;
			deliveryDetails.url = detailsData.URL;

			return deliveryDetails;
		}  // parseDigitalDeliveryDetails


		/**
		 * Creates a Distance object.
		 * 
		 * @param distanceData The XML relevant to the Distance object
		 * @return A new Distance object
		 */
		internal static function parseDistance(distanceData:XMLList):Distance
		{
			var distance:Distance = new Distance();

			distance.distanceMeasurement = int(distanceData.DistanceMeasurement);
			distance.distanceUnit = distanceData.DistanceUnit;

			return distance;
		}  // parseDistance


		/**
		 * Creates an EBayError object.
		 * 
		 * @param errorData The XML relevant to the EBayError object
		 * @return A new EBayError object
		 */
		internal static function parseEBayError(errorData:XMLList):EBayError
		{
			var ebayError:EBayError = new EBayError;

			ebayError.errorClassification = errorData.ErrorClassification;
			ebayError.errorCode = errorData.ErrorCode;
			for each (var errorParamNode:XML in errorData.ErrorParameters)
				ebayError.errorParameters.push(parseErrorParameter(XMLList(errorParamNode)));
			ebayError.longMessage = errorData.LongMessage;
			ebayError.severityCode = errorData.SeverityCode;
			ebayError.shortMessage = errorData.ShortMessage;

			return ebayError;
		}  // parseEBayError


		/**
		 * Creates an EBayItem object.
		 * 
		 * @param itemData The XML relevant to the EBayItem object
		 * @return A new EBayItem object
		 */
		ebay_internal static function parseEBayItem(itemData:XML):EBayItem
		{
			var ebayItem:EBayItem = new EBayItem();
			
			parseStandardFields(itemData, ebayItem);
			
			if (ebayItem.ack != "Success" && ebayItem.ack != "Warning")
				return ebayItem;

			ebayItem.applicationData = itemData.Item.ApplicationData;
			ebayItem.autoPay = itemData.Item.AutoPay == "true" ? true : false;
			ebayItem.bestOfferDetails = parseBestOfferDetails(itemData.Item.BestOfferDetails);
			ebayItem.buyerProtection = itemData.Item.BuyerProtection;
			ebayItem.buyerRequirements = parseBuyerRequirements(itemData.Item.BuyerRequirements);
			ebayItem.buyerResponsibleForShipping = itemData.Item.BuyerResponsibleForShipping == "true" ? true : false;
			ebayItem.buyItNowPrice = Number(itemData.Item.BuyItNowPrice);
			ebayItem.charity = parseCharity(itemData.Item.Charity);
			ebayItem.country = itemData.Item.Country;
			ebayItem.crossPromotion = parseCrossPromotion(itemData.Item.CrossPromotion);
			ebayItem.currency = itemData.Item.Currency;
			ebayItem.description = itemData.Item.Description;
			ebayItem.digitalDeliveryDetails = parseDigitalDeliveryDetails(itemData.Item.DigitalDeliveryDetails);
			ebayItem.disableBuyerRequirements = itemData.Item.DisableBuyerRequirements == "true" ? true : false;
			ebayItem.dispatchTimeMax = int(itemData.Item.DispatchTimeMax);
			ebayItem.financeOfferID = itemData.Item.FinanceOfferID;
			ebayItem.freeAddedCategory = parseCategory(itemData.Item.FreeAddedCategory);
			ebayItem.getItFast = itemData.Item.GetItFast == "true" ? true : false;
			ebayItem.giftIcon = int(itemData.Item.GiftIcon);
			for each (var serviceNode:XML in itemData.Item.GiftServices)
				ebayItem.giftServices.push(serviceNode.toString());
			ebayItem.hitCount = Number(itemData.Item.HitCount);
			ebayItem.hitCounter = itemData.Item.HitCounter;
			ebayItem.itemID = itemData.Item.ItemID;
			ebayItem.listingCheckoutRedirectPreference = parseListingCheckoutRedirectPreference(itemData.Item.ListingCheckoutRedirectPreference);
			ebayItem.listingDesigner = parseListingDesigner(itemData.Item.ListingDesigner);
			ebayItem.listingDetails = parseListingDetails(itemData.Item.ListingDetails);
			ebayItem.listingDuration = itemData.Item.ListingDuration;
			for each (var enhancementNode:XML in itemData.Item.ListingEnhancement)
				ebayItem.listingEnhancement.push(enhancementNode);
			ebayItem.listingSubtype = itemData.Item.ListingSubtype;
			ebayItem.listingType = itemData.Item.ListingType;
			ebayItem.location = itemData.Item.Location;
			ebayItem.locationDefaulted = itemData.Item.LocationDefaulted == "true" ? true : false;
			ebayItem.lotSize = int(itemData.Item.LotSize);
			ebayItem.motorsGermanySearchable = itemData.Item.MotorsGermanySearchable == "true" ? true : false;
			ebayItem.nowAndNew = itemData.Item.NowAndNew == "true" ? true : false;
			ebayItem.paymentDetails = parsePaymentDetails(itemData.Item.PaymentDetails);
			for each (var paymentMethodNode:XML in itemData.Item.PaymentMethods)
				ebayItem.paymentMethods.push(paymentMethodNode);
			ebayItem.payPalEmailAddress = itemData.Item.PayPalEmailAddress;
			ebayItem.pictureDetails = parsePictureDetails(itemData.Item.PictureDetails);
			ebayItem.postalCode = itemData.Item.PostalCode;
			ebayItem.primaryCategory = parseCategory(itemData.Item.PrimaryCategory);
			ebayItem.privateListing = itemData.Item.PrivateListing == "true" ? true : false;
			ebayItem.productListingDetails = parseProductListingDetails(itemData.Item.ProductListingDetails);
			ebayItem.proxyItem = itemData.Item.ProxyItem == "true" ? true : false;
			ebayItem.quantity = int(itemData.Item.Quantity);
			ebayItem.regionID = itemData.Item.RegionID;
			ebayItem.relisted = itemData.Item.Relisted == "true" ? true : false;
			ebayItem.relistLink = itemData.Item.RelistLink == "true" ? true : false;
			ebayItem.reservePrice = Number(itemData.Item.ReservePrice);
			ebayItem.reviseStatus = parseReviseStatus(itemData.Item.ReviseStatus);
			ebayItem.secondaryCategory = parseCategory(itemData.Item.SecondaryCategory);
			ebayItem.seller = parseEBayUser(XML(itemData.Item.Seller));
			ebayItem.sellerContactDetails = parseContactDetails(itemData.Item.SellerContactDetails);
			ebayItem.sellerInventoryID = itemData.Item.SellerInventoryID;
			ebayItem.sellerVacationNote = itemData.Item.SellerVacationNote;
			ebayItem.sellingStatus = parseSellingStatus(itemData.Item.SellingStatus);
			ebayItem.shippingDetails = parseShippingDetails(itemData.Item.ShippingDetails);
			ebayItem.shippingTermsInDescription = itemData.Item.ShippingTermsInDescription == "true" ? true : false;
			for each (var locationNode:XML in itemData.Item.ShipToLocations)
				ebayItem.shipToLocations.push(locationNode.toString());
			ebayItem.site = itemData.Item.Site;
			ebayItem.sku = itemData.Item.SKU;
			for each (var contactNode:XML in itemData.Item.SkypeContactOption)
				ebayItem.skypeContactOption.push(contactNode.toString());
			ebayItem.skypeEnabled = itemData.Item.SkypeEnabled == "true" ? true : false;
			ebayItem.skypeID = itemData.Item.SkypeID;
			ebayItem.startPrice = Number(itemData.Item.StartPrice);
			ebayItem.storeFront = parseStoreFront(itemData.Item.StoreFront);
			ebayItem.subTitle = itemData.Item.SubTitle;
			ebayItem.thirdPartyCheckout = itemData.Item.ThirdPartyCheckout == "true" ? true : false;
			ebayItem.thirdPartyCheckoutIntegration = itemData.Item.ThirdPartyCheckoutIntegration == "true" ? true : false;
			ebayItem.timeLeft = itemData.Item.TimeLeft;
			ebayItem.title = itemData.Item.Title;
			ebayItem.uuID = itemData.Item.UUID;
			ebayItem.vatDetails = parseVATDetails(itemData.Item.VATDetails);
			ebayItem.watchCount = Number(itemData.Item.WatchCount);

			return ebayItem;
		}  // parseEBayItem		


		/**
		 * Creates an EBayUser object.
		 * 
		 * @param userData The XML relevant to the EBayUser object
		 * @return A new EBayUser object
		 */
		ebay_internal static function parseEBayUser(userData:XML):EBayUser
		{
			var ebayUser:EBayUser = new EBayUser();

			parseStandardFields(userData, ebayUser);
			
			if (ebayUser.ack != "Success" && ebayUser.ack != "Warning")
				return ebayUser;

			ebayUser.aboutMePage = userData.User.AboutMePage;
			ebayUser.buyerInfo = parseBuyerInfo(userData.BuyerInfo);
			for each (var charityNode:XML in userData.User.CharityAffiliations)
				ebayUser.charityAffiliations.push(charityNode.toString());
			ebayUser.eBayGoodStanding = userData.User.eBayGoodStanding == "true" ? true : false;
			ebayUser.eBayWikiReadOnly = userData.User.eBayWikiReadOnly == "true" ? true : false;
			ebayUser.eiasToken = userData.User.EIASToken;			
			ebayUser.email = userData.User.Email;
			ebayUser.feedbackPrivate = userData.User.feedbackPrivate == "true" ? true : false;
			ebayUser.feedbackRatingStar = userData.User.FeedbackRatingStar;
			ebayUser.feedbackScore = int(userData.User.FeedbackScore);
			ebayUser.idVerified = userData.User.IDVerified == "true" ? true : false;
			ebayUser.motorsDealer = userData.User.MotorsDealer == "true" ? true : false;
			ebayUser.newUser = userData.User.NewUser == "true" ? true : false;
			ebayUser.payPalAccountLevel = userData.User.PayPalAccountLevel;
			ebayUser.payPalAccountStatus = userData.User.PayPalAccountStatus;
			ebayUser.payPalAccountType = userData.User.PayPalAccountType;
			ebayUser.positiveFeedbackPercent = Number(userData.User.PositiveFeedbackPercent);
			ebayUser.registrationAddress = parseAddress(userData.User.RegistrationAddress);
			ebayUser.registrationDate = parseDateString(userData.User.RegistrationDate);
			ebayUser.restToken = userData.User.RESTToken;
			ebayUser.sellerInfo = parseSellerInfo(userData.User.SellerInfo);
			ebayUser.sellerPaymentMethod = userData.User.SellerPaymentMethod;
			ebayUser.site = userData.User.Site;
			for each (var skypeIDNode:XML in userData.User.SkypeID)
				ebayUser.skypeID.push(skypeIDNode.toString());
			ebayUser.status = userData.User.Status;
			ebayUser.tuvLevel = userData.User.TUVLevel;
			ebayUser.uniqueNegativeFeedbackCount = int(userData.User.UniqueNegativeFeedbackCount);
			ebayUser.uniquePositiveFeedbackCount = int(userData.User.UniquePositiveFeedbackCount);
			ebayUser.userID = userData.User.UserID;
			ebayUser.userIDChanged = userData.User.UserIDChanged == "true" ? true : false;
			ebayUser.userIDLastChanged = parseDateString(userData.User.UserIDLastChanged);
			for each (var userSubscriptionNode:XML in userData.User.UserSubscription)
				ebayUser.userSubscription.push(userSubscriptionNode.toString());
			ebayUser.vatID = userData.User.VATID;
			ebayUser.vatStatus = userData.user.VATStatus;			

			return ebayUser;
		}  // parseEBayUser


		/**
		 * Creates an ErrorParameter object.
		 * 
		 * @param parameterData The XML relevant for the ErrorParameter object
		 * @return A new ErrorParameter object
		 */
		internal static function parseErrorParameter(parameterData:XMLList):ErrorParameter
		{
			var errorParameter:ErrorParameter = new ErrorParameter();

			errorParameter.value = parameterData.Value;

			return errorParameter;
		}  // parseErrorParameter


		/**
		 * Creates an ExpressItemRequirements object.
		 * 
		 * @param requirementsData The XML relevant for the ExpressItemRequirements object
		 * @return A new ExpressItemRequirements object
		 */
		internal static function parseExpressItemRequirements(requirementsData:XMLList):ExpressItemRequirements
		{
			var expressItemRequirements:ExpressItemRequirements = new ExpressItemRequirements();

			expressItemRequirements.combinedShippingDiscount = requirementsData.CombinedShippingDiscount == "true" ? true : false;
			expressItemRequirements.domesticShippingCost = requirementsData.DomesticShippingCost == "true" ? true : false;
			expressItemRequirements.eligibleCheckout = requirementsData.EligibleCheckout == "true" ? true : false;
			expressItemRequirements.eligibleItemCondition = requirementsData.EligibleItemCondition == "true" ? true : false;
			expressItemRequirements.eligiblePayPalAccount = requirementsData.EligiblePayPalAccount == "true" ? true : false;
			expressItemRequirements.eligibleReturnPolicy = requirementsData.EligibleReturnPolicy == "true" ? true : false;
			expressItemRequirements.expressApproved = requirementsData.ExpressApproved == "true" ? true : false;
			expressItemRequirements.expressEligibleListingType = requirementsData.ExpressEligibleListingType == "true" ? true : false;
			expressItemRequirements.expressEnabledCategory = requirementsData.ExpressEnabledCategory == "true" ? true : false;
			expressItemRequirements.expressOptOut = requirementsData.ExpressOptOut == "true" ? true : false;
			expressItemRequirements.noCharity = requirementsData.NoCharity == "true" ? true : false;
			expressItemRequirements.noDigitalDelivery = requirementsData.NoDigitalDelivery == "true" ? true : false;
			expressItemRequirements.noPreapprovedBidderList = requirementsData.NoPreapprovedBidderList == "true" ? true : false;
			expressItemRequirements.payPalAccountAcceptsUnconfirmedAddress = requirementsData.PayPalAccountAcceptsUnconfirmedAddress ? true : false;
			expressItemRequirements.picture = requirementsData.Picture == "true" ? true : false;
			expressItemRequirements.priceAboveMinimum = requirementsData.PriceAboveMinimum == "true" ? true : false;
			expressItemRequirements.priceBelowMaximum = requirementsData.PriceBelowMaximum == "true" ? true : false;
			expressItemRequirements.sellerExpressEligible = requirementsData.SellerExpressEligible == "true" ? true : false;
			expressItemRequirements.shipFromEligibleCountry = requirementsData.ShipFromEligibleCountry == "true" ? true : false;

			return expressItemRequirements;
		}  // parseExpressItemRequirements


		/**
		 * Creates an ExpressSellerRequirements object.
		 * 
		 * @param expressSellerRequirementsData The XML relevant to the ExpressSellerRequirements object
		 * @return A new ExpressSellerRequirements object
		 */
		internal static function parseExpressSellerRequirements(expressSellerRequirementsData:XMLList):ExpressSellerRequirements
		{
			var expressSellerRequirements:ExpressSellerRequirements = new ExpressSellerRequirements();

			expressSellerRequirements.businessSeller = expressSellerRequirementsData.BusinessSeller == "true" ? true : false;
			expressSellerRequirements.combinedPaymentsAccepted = expressSellerRequirementsData.CombinedPaymentsAccepted == "true" ? true : false;
			expressSellerRequirements.eligiblePayPalAccount = expressSellerRequirementsData.EligiblePayPalAccount == "true" ? true : false;
			expressSellerRequirements.expressApproved = expressSellerRequirementsData.ExpressApproved == "true" ? true : false;
			expressSellerRequirements.expressSellingPreference = expressSellerRequirementsData.ExpressSellingPreference == "true" ? true : false;
			expressSellerRequirements.feedbackAsSellerScore = expressSellerRequirementsData.FeedbackAsSellerScore == "true" ? true : false;
			expressSellerRequirements.feedbackPublic = expressSellerRequirementsData.FeedbackPublic == "true" ? true : false;
			expressSellerRequirements.feedbackScore = expressSellerRequirementsData.FeedbackScore == "true" ? true : false;
			expressSellerRequirements.goodStanding = expressSellerRequirementsData.GoodStanding == "true" ? true : false;
			expressSellerRequirements.payPalAccountAcceptsUnconfirmedAddress = expressSellerRequirementsData.PayPalAccountAcceptsUnconfirmedAddress == "true" ? true : false;
			expressSellerRequirements.positiveFeedbackAsSellerPercent = expressSellerRequirementsData.PositiveFeedbackAsSellerPercent == "true" ? true : false;
			expressSellerRequirements.positiveFeedbackPercent = expressSellerRequirementsData.PositiveFeedbackPercent == "true" ? true : false;

			return expressSellerRequirements;
		}  // parseExpressSellerRequirements


		/**
		 * Creates an InsuranceDetails object.
		 * 
		 * @param detailsData The XML relevant to the InsuranceDetails object
		 * @return A new InsuranceDetails object
		 */
		internal static function parseInsuranceDetails(detailsData:XMLList):InsuranceDetails
		{
			var insuranceDetails:InsuranceDetails = new InsuranceDetails();

			insuranceDetails.insuranceFee = Number(detailsData.InsuranceFee);
			insuranceDetails.insuranceOption = detailsData.InsuranceOption;

			return insuranceDetails;
		}  // parseInsuranceDetails


		/**
		 * Creates an Item object.
		 * 
		 * @param itemData The XML relevant to the Item object
		 * @return A new Item object
		 */
		internal static function parseItem(itemData:XMLList):Item
		{
			var item:Item = new Item();

			item.bestOfferEnabled = itemData.BestOfferEnabled;
			item.buyerProtection = itemData.BuyerProtection;
			item.buyItNowPrice = Number(itemData.BuyItNowPrice);
			item.country = itemData.Country;
			item.currency = itemData.Currency;
			item.digitalDeliveryDetails = parseDigitalDeliveryDetails(itemData.DigitalDeliveryDetails);
			item.distance = parseDistance(itemData.Distance);
			item.itemID = itemData.ItemID;
			item.listingDetails = parseListingDetails(itemData.ListingDetails);
			item.listingDuration = itemData.ListingDuration;
			for each (var listingEnhancementNode:XML in itemData.ListingEnhancement)
				item.listingEnhancement.push(listingEnhancementNode);
			item.listingType = itemData.ListingType;
			item.localListing = itemData.LocalListing == "true" ? true : false;
			item.motorsGermanySearchable = itemData.MotorsGermanySearchable == "true" ? true : false;
			for each (var paymentMethodsNode:XML in itemData.PaymentMethods)
				item.paymentMethods.push(paymentMethodsNode);
			item.pictureDetails = parsePictureDetails(itemData.PictureDetails);
			item.postalCode = itemData.PostalCode;
			item.primaryCategory = parseCategory(itemData.PrimaryCategory);
			item.searchDetails = parseSearchDetails(itemData.SearchDetails);
			item.secondaryCategory = parseCategory(itemData.SecondaryCategory);
			item.seller = itemData.Seller;
			item.sellingStatus = parseSellingStatus(itemData.SellingStatus);
			item.shippingDetails = parseShippingDetails(itemData.ShippingDetails);
			item.storeFront = parseStoreFront(itemData.StoreFront);
			item.title = itemData.Title;

			return item;
		}  // parseItem


		/**
		 * Creates an ItemSpecific object.
		 * 
		 * @param itemSpecificData The XML relevant to the ItemSpecific object
		 * @return A new ItemSpecific object
		 */
		internal static function parseItemSpecific(itemSpecificData:XMLList):ItemSpecific
		{
			var itemSpecific:ItemSpecific = new ItemSpecific();

			for each (var nameValueListNode:XML in itemSpecificData.NameValueList)
			{
				var nameValueList:NameValueList = new NameValueList();
				
				nameValueList.name = nameValueListNode.Name;
				for each (var valueNode:XML in nameValueListNode.Value)
					nameValueList.value.push(valueNode);
				
				itemSpecific.nameValueList.push(nameValueList);
			}  // for each loop

			return itemSpecific;
		}  // parseItemSpecific


		/**
		 * Creates a ListingCheckoutRedirectPreference object.
		 * 
		 * @param preferenceData The XML relevant to the ListingCheckoutRedirectPreference object
		 * @return A new ListingCheckoutRedirectPreference object
		 */
		internal static function parseListingCheckoutRedirectPreference(preferenceData:XMLList):ListingCheckoutRedirectPreference
		{
			var listingCheckoutRedirectPreference:ListingCheckoutRedirectPreference = new ListingCheckoutRedirectPreference();

			listingCheckoutRedirectPreference.sellerThirdPartyUsername = preferenceData.SellerThirdPartyUsername;

			return listingCheckoutRedirectPreference;
		}  // parseListingCheckoutRedirectPreference


		/**
		 * Creates a ListingDesigner object.
		 * 
		 * @param designerData The XML relevant to the ListingDesigner object
		 * @return A new ListingDesigner object
		 */
		internal static function parseListingDesigner(designerData:XMLList):ListingDesigner
		{
			var listingDesigner:ListingDesigner = new ListingDesigner();

			listingDesigner.layoutID = int(designerData.LayoutID);
			listingDesigner.optimalPictureSize = designerData.OptimalPictureSize == "true" ? true : false;
			listingDesigner.themeID = int(designerData.ThemeID);

			return listingDesigner;
		}  // parseListingDesigner


		/**
		 * Creates a ListingDetails object.
		 * 
		 * @param detailsData The XML relevant to the ListingDetails object
		 * @return A new ListingDetails object
		 */
		internal static function parseListingDetails(detailsData:XMLList):ListingDetails
		{
			var listingDetails:ListingDetails = new ListingDetails();

			listingDetails.adult = detailsData.Adult == "true" ? true : false;
			listingDetails.bindingAuction = detailsData.BindingAuction == "true" ? true : false;
			listingDetails.buyItNowAvailable = detailsData.BuyItNowAvailable == "true" ? true : false;
			listingDetails.checkoutEnabled = detailsData.CheckoutEnabled == "true" ? true : false;
			listingDetails.convertedBuyItNowPrice = Number(detailsData.ConvertedBuyItNowPrice);
			listingDetails.convertedReservePrice = Number(detailsData.ConvertedReservePrice);
			listingDetails.convertedStartPrice = Number(detailsData.ConvertedStartPrice);
			listingDetails.endTime = parseDateString(detailsData.EndTime);
			listingDetails.expressItemRequirements = parseExpressItemRequirements(detailsData.ExpressItemRequirements);
			listingDetails.expressListing = detailsData.ExpressListing == "true" ? true : false;
			listingDetails.hasPublicMessages = detailsData.HasPublicMessage == "true" ? true : false;
			listingDetails.hasReservePrice = detailsData.HasReservePrice == "true" ? true : false;
			listingDetails.hasUnansweredQuestions = detailsData.HasUnansweredQuestions == "true" ? true : false;
			listingDetails.minimumBestOfferMessage = detailsData.MinimumBestOfferMessage;
			listingDetails.minimumBestOfferPrice = Number(detailsData.MinimumBestOfferPrice);
			listingDetails.relistedItemID = detailsData.RelistedItemID;
			listingDetails.secondChanceOriginalItemID = detailsData.SecondChanceOriginalItemID;
			listingDetails.sellerBusinessType = detailsData.SellerBusinessType;
			listingDetails.startTime = parseDateString(detailsData.StartTime);
			listingDetails.tcrOriginalItemID = detailsData.TCROriginalItemID;
			listingDetails.viewItemURL = detailsData.ViewItemURL;

			return listingDetails;
		}  // parseListingDetails


		/**
		 * Creates a LostList object.
		 * 
		 * @param listData The XML relevant to the LostList object
		 * @return A new LostList object
		 */
		internal static function parseLostList(listData:XMLList):LostList
		{
			var lostList:LostList = new LostList();

			for each (var lostListNode:XML in listData.ItemArray.Item)
				lostList.lostListItem.push(parseLostListItem(XMLList(lostListNode)));
			lostList.paginationResult = parsePaginationResult(listData.PaginationResult);

			return lostList;
		}  // parseLostList


		/**
		 * Creates a LostListItem object.
		 * 
		 * @param itemData The XML relevant to the LostListItem object
		 * @return A new LostListItem object
		 */
		internal static function parseLostListItem(itemData:XMLList):LostListItem
		{
			var lostListItem:LostListItem = new LostListItem();

			lostListItem.biddingDetails = parseBiddingDetails(itemData.BiddingDetails);
			lostListItem.eBayNotes = itemData.eBayNotes;
			lostListItem.itemID = itemData.ItemID;
			lostListItem.listingDetails = parseListingDetails(itemData.ListingDetails);
			lostListItem.listingType = itemData.ListingType;
			lostListItem.seller = parseSellerInfo(itemData.Seller);
			lostListItem.sellingStatus = parseSellingStatus(itemData.SellingStatus);
			lostListItem.site = itemData.Site;
			lostListItem.startPrice = Number(itemData.StartPrice);
			lostListItem.title = itemData.Title;

			return lostListItem;
		}  // parseLostListItem


		/**
		 * Creates a MaximumItemRequirements object.
		 * 
		 * @param requirementsData The XML relevant to the MaximumItemRequirements object
		 * @return A new MaximumItemRequirements object
		 */
		internal static function parseMaximumItemRequirements(requirementsData:XMLList):MaximumItemRequirements
		{
			var maximumItemRequirements:MaximumItemRequirements = new MaximumItemRequirements();

			maximumItemRequirements.maximumItemCount = int(requirementsData.MaximumItemCount);
			maximumItemRequirements.minimumFeedbackScore = int(requirementsData.MinimumFeedbackScore);

			return maximumItemRequirements;
		}  // parseMaximumItemRequirements


		/**
		 * Creates a MyEBayBuyingItems object.
		 * 
		 * @param requirementsData The XML relevant to the MyEBayBuyingItems object
		 * @return A new MyEBayBuyingItems object
		 */
		ebay_internal static function parseMyEBayBuyingItems(itemsData:XML):MyEBayBuyingItems
		{
			var myEBayBuyingItems:MyEBayBuyingItems = new MyEBayBuyingItems();
			
			parseStandardFields(itemsData, myEBayBuyingItems);
			
			if (myEBayBuyingItems.ack != "Success" && myEBayBuyingItems.ack != "Warning")
				return myEBayBuyingItems;

			myEBayBuyingItems.bidList = parseBidList(itemsData.BidList);
			myEBayBuyingItems.buyingSummary = parseBuyingSummary(itemsData.BuyingSummary);
			myEBayBuyingItems.lostList = parseLostList(itemsData.LostList);
			myEBayBuyingItems.watchList = parseWatchList(itemsData.WatchList);

			return myEBayBuyingItems;
		}  // parseMyEBayBuyingItems


		/**
		 * Creates a PaginationResult object.
		 * 
		 * @param requirementsData The XML relevant to the PaginationResult object
		 * @return A new PaginationResult object
		 */
		internal static function parsePaginationResult(paginationData:XMLList):PaginationResult
		{
			var paginationResult:PaginationResult = new PaginationResult();

			paginationResult.totalNumberOfEntries = int(paginationData.TotalNumberOfEntries);
			paginationResult.totalNumberOfPages = int(paginationData.TotalNumberOfPages);

			return paginationResult;
		}  // parsePaginationResult


		/**
		 * Creates a PaymentDetails object.
		 * 
		 * @param requirementsData The XML relevant to the PaymentDetails object
		 * @return A new PaymentDetails object
		 */
		internal static function parsePaymentDetails(detailsData:XMLList):PaymentDetails
		{
			var paymentDetails:PaymentDetails = new PaymentDetails();

			paymentDetails.daysToFullPayment = int(detailsData.DaysToFullPayment);
			paymentDetails.hoursToDeposit = int(detailsData.HoursToDeposit);

			return paymentDetails;
		}  // parsePaymentDetails


		/**
		 * Creates a PictureDetails object.
		 * 
		 * @param requirementsData The XML relevant to the PictureDetails object
		 * @return A new PictureDetails object
		 */
		internal static function parsePictureDetails(detailsData:XMLList):PictureDetails
		{
			var pictureDetails:PictureDetails = new PictureDetails();

			pictureDetails.galleryType = detailsData.GalleryType;
			pictureDetails.galleryURL = detailsData.GalleryURL;
			pictureDetails.photoDisplay = detailsData.PhotoDisplay;
			pictureDetails.pictureSource = detailsData.PictureSource;
			for each (var pictureURLNode:XML in detailsData.PictureURL)
				pictureDetails.pictureURL.push(pictureURLNode);

			return pictureDetails;
		}  // parsePictureDetails


		/**
		 * Creates a PlaceOfferResult object.
		 * 
		 * @param requirementsData The XML relevant to the PlaceOfferResult object
		 * @return A new PlaceOfferResult object
		 */
		ebay_internal static function parsePlaceOfferResult(resultData:XML):PlaceOfferResult
		{
			var placeOfferResult:PlaceOfferResult = new PlaceOfferResult();

			parseStandardFields(resultData, placeOfferResult);
			
			if (placeOfferResult.ack != "Success" && placeOfferResult.ack != "Warning")
				return placeOfferResult;

			placeOfferResult.sellingStatus = parseSellingStatus(resultData.SellingStatus);

			return placeOfferResult;
		}  // parsePlaceOfferResult


		/**
		 * Creates a ProductListingDetails object.
		 * 
		 * @param requirementsData The XML relevant to the ProductListingDetails object
		 * @return A new ProductListingDetails object
		 */
		internal static function parseProductListingDetails(detailsData:XMLList):ProductListingDetails
		{
			var productListingDetails:ProductListingDetails = new ProductListingDetails();

			for each (var copyrightNode:XML in detailsData.Copyright)
				productListingDetails.copyright.push(copyrightNode);
			productListingDetails.includePrefilledItemInformation = detailsData.IncludePrefilledItemInformation == "true" ? true : false;
			productListingDetails.includeStockPhotoURL = detailsData.IncludeStockPhotoURL == "true" ? true : false;
			productListingDetails.productID = detailsData.ProductID;
			productListingDetails.stockPhotoURL = detailsData.StockPhotoURL;
			productListingDetails.useStockPhotoURLAsGallery = detailsData.UseStockPhotoURLAsGallery == "true" ? true : false;

			return productListingDetails;
		}  // parseProductListingDetails


		/**
		 * Creates a PromotedItem object.
		 * 
		 * @param requirementsData The XML relevant to the PromotedItem object
		 * @return A new PromotedItem object
		 */
		internal static function parsePromotedItem(itemData:XMLList):PromotedItem
		{
			var promotedItem:PromotedItem = new PromotedItem();

			promotedItem.itemID = itemData.ItemID;
			promotedItem.listingType = itemData.ListingType;
			promotedItem.pictureURL = itemData.PictureURL;
			promotedItem.position = int(itemData.Position);
			promotedItem.promotionPrice = Number(itemData.PromotionPrice);
			promotedItem.promotionPriceType = itemData.PromotionPriceType;
			promotedItem.selectionType = itemData.SelectionType;
			promotedItem.title = itemData.Title;

			return promotedItem;
		}  // parsePromotedItem


		/**
		 * Creates a ReviseStatus object.
		 * 
		 * @param requirementsData The XML relevant to the ReviseStatus object
		 * @return A new ReviseStatus object
		 */
		internal static function parseReviseStatus(statusData:XMLList):ReviseStatus
		{
			var reviseStatus:ReviseStatus = new ReviseStatus();

			reviseStatus.buyItNowAdded = statusData.BuyItNowAdded == "true" ? true : false;
			reviseStatus.buyItNowLowered = statusData.BuyItNowLowered == "true" ? true : false;
			reviseStatus.itemRevised = statusData.ItemRevised == "true" ? true : false;
			reviseStatus.reserveLowered = statusData.ReserveLowered == "true" ? true : false;
			reviseStatus.reserveRemoved = statusData.ReserveRemoved == "true" ? true : false;

			return reviseStatus;
		}  // parseReviseStatus


		/**
		 * Creates a SalesTax object.
		 * 
		 * @param requirementsData The XML relevant to the SalesTax object
		 * @return A new SalesTax object
		 */
		internal static function parseSalesTax(taxData:XMLList):SalesTax
		{
			var salesTax:SalesTax = new SalesTax();

			salesTax.salesTaxAmount = Number(taxData.SalesTaxAmount);
			salesTax.salesTaxPercent = Number(taxData.SalesTaxPercent);
			salesTax.salesTaxState = taxData.SalesTaxState;
			salesTax.shippingIncludedInTax = taxData.ShippingIncludedInTax;

			return salesTax;
		}  // parseSalesTax


		/**
		 * Creates a SchedulingInfo object.
		 * 
		 * @param requirementsData The XML relevant to the SchedulingInfo object
		 * @return A new SchedulingInfo object
		 */
		internal static function parseSchedulingInfo(schedulingInfoData:XMLList):SchedulingInfo
		{
			var schedulingInfo:SchedulingInfo = new SchedulingInfo;

			schedulingInfo.maxScheduledItems = int(schedulingInfoData.MaxScheduledItems);
			schedulingInfo.maxScheduledMinutes = int(schedulingInfoData.MaxScheduledMinutes);
			schedulingInfo.minScheduledMinutes = int(schedulingInfoData.MinScheduledMinutes);

			return schedulingInfo;
		}  // parseSchedulingInfo


		/**
		 * Creates a SearchDetails object.
		 * 
		 * @param requirementsData The XML relevant to the SearchDetails object
		 * @return A new SearchDetails object
		 */
		internal static function parseSearchDetails(detailsData:XMLList):SearchDetails
		{
			var searchDetails:SearchDetails = new SearchDetails();

			searchDetails.buyItNowEnabled = detailsData.BuyItNowEnabled == "true" ? true : false;
			searchDetails.picture = detailsData.Picture == "true" ? true : false;
			searchDetails.recentListing = detailsData.RecentListing == "true" ? true : false;

			return searchDetails;
		}  // parseSearchDetails


		/**
		 * Creates a SearchResults object.
		 * 
		 * @param requirementsData The XML relevant to the SearchResults object
		 * @return A new SearchResults object
		 */
		ebay_internal static function parseSearchResults(resultData:XML):SearchResults
		{
			var searchResults:SearchResults = new SearchResults();
			
			parseStandardFields(resultData, searchResults);
			
			if (searchResults.ack != "Success" && searchResults.ack != "Warning")
				return searchResults;

			searchResults.hasMoreItems = resultData.HasMoreItems == "true" ? true : false;
			searchResults.itemsPerPage = int(resultData.ItemsPerPage);
			searchResults.pageNumber = int(resultData.PageNumber);
			searchResults.paginationResult = parsePaginationResult(resultData.PaginationResult);
			for each (var searchResultNode:XML in resultData.SearchResultItemArray.SearchResultItem)
			{
				var searchResultItem:SearchResultItem = new SearchResultItem();
				
				searchResultItem.item = parseItem(searchResultNode.Item);
				searchResultItem.itemSpecific = parseItemSpecific(searchResultNode.ItemSpecific);
				for each (var searchResultValuesNode:XML in searchResultNode.SearchResultValues)
					searchResultItem.searchResultValues.push(searchResultValuesNode);
								
				searchResults.searchResultItems.push(searchResultItem);
			}  // for each loop

			return searchResults;
		}  // parseSearchResults


		/**
		 * Creates a SellerInfo object.
		 * 
		 * @param requirementsData The XML relevant to the SellerInfo object
		 * @return A new SellerInfo object
		 */
		internal static function parseSellerInfo(sellerData:XMLList):Seller
		{
			var seller:Seller = new Seller();

			seller.allowPaymentEdit = sellerData.AllowPaymentEdit == "true" ? true : false;
			seller.billingCurrency = sellerData.BillingCurrency;
			seller.charityRegistered = sellerData.CharityRegistered == "true" ? true : false;
			seller.checkoutEnabled = sellerData.CheckoutEnabled == "true" ? true : false;
			seller.cipBankAccountStored = sellerData.CIPBankAccountStored == "true" ? true : false;
			seller.expressEligible = sellerData.ExpressEligibl == "true" ? true : false;
			seller.expressSellerRequirements = parseExpressSellerRequirements(sellerData.ExpressSellerRequirements);
			seller.expressWallet = sellerData.ExpressWallet == "true" ? true : false;
			seller.goodStanding = sellerData.GoodStanding == "true" ? true : false;
			seller.liveAuctionAuthorized = sellerData.LiveAuctionAuthorized == "true" ? true : false;
			seller.merchandizingPref = sellerData.MerchandizingPref; 
			seller.paisaPayStatus = int(sellerData.PaisaPayStatus);
			seller.proStorePreference = sellerData.ProStorePreference;
			seller.qualifiesForB2BVAT = sellerData.QualifiesForB2BVAT == "true" ? true : false;
			seller.registeredBusinessSeller = sellerData.RegisteredBusinessSeller == "true" ? true : false;
			seller.schedulingInfo = parseSchedulingInfo(sellerData.SchedulingInfo);
			seller.sellerBusinessType = sellerData.SellerBusinessType;
			seller.sellerGuaranteeLevel = sellerData.SellerGuaranteeLevel;
			seller.sellerLevel = sellerData.SellerLevel;
			seller.sellerPaymentAddress = parseAddress(sellerData.SellerPaymentAddress);
			seller.storeOwner = sellerData.StoreOwner == "true" ? true : false;
			seller.storeURL = sellerData.StoreURL;
			seller.userID = sellerData.UserID;

			return seller;
		}  // parseSellerInfo


		/**
		 * Creates a SellingStatus object.
		 * 
		 * @param requirementsData The XML relevant to the SellingStatus object
		 * @return A new SellingStatus object
		 */
		internal static function parseSellingStatus(statusData:XMLList):SellingStatus
		{
			var sellingStatus:SellingStatus = new SellingStatus();

			sellingStatus.bidCount = int(statusData.BidCount);
			sellingStatus.bidIncrement = Number(statusData.BidIncrement);
			sellingStatus.convertedCurrentPrice = Number(statusData.ConvertedCurrentPrice);
			sellingStatus.currentPrice = Number(statusData.CurrentPrice);
			sellingStatus.highBidder = parseUser(XMLList(statusData.HighBidder));
			sellingStatus.leadCount = int(statusData.LeadCount);
			sellingStatus.listingStatus = statusData.ListingStatus;
			sellingStatus.minimumToBid = int(statusData.MinimumToBid);
			sellingStatus.quantitySold = int(statusData.QuantitySold);
			sellingStatus.reserveMet = statusData.ReserveMet == "true" ? true : false;
			sellingStatus.secondChanceEligible = statusData.SecondChanceEligible == "true" ? true : false;

			return sellingStatus;
		}  // parseSellingStatus


		/**
		 * Creates a ShippingDetails object.
		 * 
		 * @param requirementsData The XML relevant to the ShippingDetails object
		 * @return A new ShippingDetails object
		 */
		internal static function parseShippingDetails(detailsData:XMLList):ShippingDetails
		{
			var shippingDetails:ShippingDetails = new ShippingDetails();

			shippingDetails.applyShippingDiscount = detailsData.ApplyShippingDiscount == "true" ? true : false;
			shippingDetails.calculatedShippingRate = parseCalculatedShippingRate(detailsData.CalculatedShippingRate);
			shippingDetails.defaultShippingCost = Number(detailsData.DefaultShippingCost);
			shippingDetails.getItFast = detailsData.GetItFast == "true" ? true : false;
			shippingDetails.insuranceDetails = parseInsuranceDetails(detailsData.InsuranceDetails);
			shippingDetails.insuranceFee = Number(detailsData.InsuranceFee);
			shippingDetails.insuranceOption = detailsData.InsuranceOption;
			shippingDetails.internationalInsuranceDetails = parseInsuranceDetails(detailsData.InternationalInsuranceDetails);
			for each (var internationalServiceOptionNode:XMLList in detailsData.InternationalShippingServiceOption)
				shippingDetails.internationalShippingServiceOption.push(parseShippingServiceOption(internationalServiceOptionNode));
			shippingDetails.paymentInstructions = detailsData.PaymentInstructions;
			shippingDetails.salesTax = parseSalesTax(detailsData.SalesTax);
			shippingDetails.sellingManagerSalesRecordNumber = int(detailsData.SellingManagerSalesRecordNumber);
			shippingDetails.shippingRateType = detailsData.ShippingRateType;
			for each (var serviceOptionNode:XMLList in detailsData.ShippingServiceOption)
				shippingDetails.shippingServiceOptions.push(parseShippingServiceOption(serviceOptionNode));
			shippingDetails.shippingType = detailsData.ShippingType;
			shippingDetails.taxTable = parseTaxTable(detailsData.TaxTable);
			shippingDetails.thirdPartyCheckout = detailsData.ThirdPartyCheckout == "true" ? true : false;

			return shippingDetails;
		}  // parseShippingDetails


		/**
		 * Creates a ShippingServiceOption object.
		 * 
		 * @param requirementsData The XML relevant to the ShippingServiceOption object
		 * @return A new ShippingServiceOption object
		 */
		internal static function parseShippingServiceOption(optionData:XMLList):ShippingServiceOption
		{
			var shippingServiceOption:ShippingServiceOption = new ShippingServiceOption();

			shippingServiceOption.expeditedService = optionData.ExpeditedService == "true" ? true : false;
			shippingServiceOption.shippingInsuranceCost = Number(optionData.ShippingInsuranceCost);
			shippingServiceOption.shippingService = optionData.ShippingService;
			shippingServiceOption.shippingServiceAdditionalCost = Number(optionData.ShippingServiceAdditionalCost);
			shippingServiceOption.shippingServiceCost = Number(optionData.ShippingServiceCost);
			shippingServiceOption.shippingServicePriority = int(optionData.ShippingServicePriority);
			shippingServiceOption.shippingSurcharge = Number(optionData.ShippingSurcharge);
			shippingServiceOption.shippingTimeMax = int(optionData.ShippingTimeMax);
			shippingServiceOption.shippingTimeMin = int(optionData.ShippingTimeMin);
			for each (var locationNode:XML in optionData.ShipToLocation)
				shippingServiceOption.shipToLocation.push(locationNode.toString());

			return shippingServiceOption;
		}  // parseShippingServiceOption


		/**
		 * Parses the standard output fields in an eBay result and sets the member variables of
		 * the passed in object, ebayResult.
		 * 
		 * @param resultData The XML of the standard output fields in the eBay result
		 * @param ebayResult The object of which member variables to set
		 */
		internal static function parseStandardFields(resultData:XML, ebayResult:EBayResult):void
		{
			ebayResult.ack = resultData.Ack;
			ebayResult.build = resultData.Build;
			ebayResult.correlationID = resultData.CorrelationID;
			for each (var ebayErrorNode:XML in resultData.Errors)
			{
				ebayResult.errors.push(parseEBayError(XMLList(ebayErrorNode)));
			}
			ebayResult.hardExpirationWarning = resultData.HardExpirationWarning;
			ebayResult.timestamp = parseDateString(resultData.Timestamp);
			ebayResult.version = resultData.Version;			
			ebayResult.rawResult = resultData.toString();
		}  // parseStandardFields


		/**
		 * Creates a StoreFront object.
		 * 
		 * @param requirementsData The XML relevant to the StoreFront object
		 * @return A new StoreFront object
		 */
		internal static function parseStoreFront(storeFrontData:XMLList):StoreFront
		{
			var storeFront:StoreFront = new StoreFront();

			storeFront.storeName = storeFrontData.StoreName;
			storeFront.storeURL = storeFrontData.StoreURL;

			return storeFront;
		}  // parseStoreFront


		/**
		 * Creates a TaxJurisdiction object.
		 * 
		 * @param requirementsData The XML relevant to the TaxJurisdiction object
		 * @return A new TaxJurisdiction object
		 */
		internal static function parseTaxJurisdiction(jurisdictionData:XMLList):TaxJurisdiction
		{
			var taxJurisdiction:TaxJurisdiction = new TaxJurisdiction();

			taxJurisdiction.jurisdictionID = jurisdictionData.JurisdictionID;
			taxJurisdiction.salesTaxPercent = Number(jurisdictionData.SalesTaxPercent);
			taxJurisdiction.shippingIncludedInTax = jurisdictionData.ShippingIncludedInTax == "true" ? true : false;

			return taxJurisdiction;
		}  // parseTaxJurisdiction


		/**
		 * Creates a TaxTable object.
		 * 
		 * @param requirementsData The XML relevant to the TaxTable object
		 * @return A new TaxTable object
		 */
		internal static function parseTaxTable(tableData:XMLList):TaxTable
		{
			var taxTable:TaxTable = new TaxTable();

			for each (var jurisdictionNode:XML in tableData.TaxJurisdiction)
				taxTable.taxJurisdiction.push(parseTaxJurisdiction(tableData.TaxJurisdiction));

			return taxTable;
		}  // parseTaxTable


		/**
		 * Creates a User object.
		 * 
		 * @param requirementsData The XML relevant to the User object
		 * @return A new User object
		 */
		internal static function parseUser(userData:XMLList):EBayUser
		{
			var ebayUser:EBayUser = new EBayUser();

			ebayUser.aboutMePage = userData.User.AboutMePage;
			ebayUser.buyerInfo = parseBuyerInfo(userData.BuyerInfo);
			for each (var charityNode:XML in userData.User.CharityAffiliations)
				ebayUser.charityAffiliations.push(charityNode.toString());
			ebayUser.eBayGoodStanding = userData.User.eBayGoodStanding == "true" ? true : false;
			ebayUser.eBayWikiReadOnly = userData.User.eBayWikiReadOnly == "true" ? true : false;
			ebayUser.eiasToken = userData.User.EIASToken;			
			ebayUser.email = userData.User.Email;
			ebayUser.feedbackPrivate = userData.User.feedbackPrivate == "true" ? true : false;
			ebayUser.feedbackRatingStar = userData.User.FeedbackRatingStar;
			ebayUser.feedbackScore = int(userData.User.FeedbackScore);
			ebayUser.idVerified = userData.User.IDVerified == "true" ? true : false;
			ebayUser.motorsDealer = userData.User.MotorsDealer == "true" ? true : false;
			ebayUser.newUser = userData.User.NewUser == "true" ? true : false;
			ebayUser.payPalAccountLevel = userData.User.PayPalAccountLevel;
			ebayUser.payPalAccountStatus = userData.User.PayPalAccountStatus;
			ebayUser.payPalAccountType = userData.User.PayPalAccountType;
			ebayUser.positiveFeedbackPercent = Number(userData.User.PositiveFeedbackPercent);
			ebayUser.registrationAddress = parseAddress(userData.User.RegistrationAddress);
			ebayUser.registrationDate = parseDateString(userData.User.RegistrationDate);
			ebayUser.restToken = userData.User.RESTToken;
			ebayUser.sellerInfo = parseSellerInfo(userData.User.SellerInfo);
			ebayUser.sellerPaymentMethod = userData.User.SellerPaymentMethod;
			ebayUser.site = userData.User.Site;
			for each (var skypeIDNode:XML in userData.User.SkypeID)
				ebayUser.skypeID.push(skypeIDNode.toString());
			ebayUser.status = userData.User.Status;
			ebayUser.tuvLevel = userData.User.TUVLevel;
			ebayUser.uniqueNegativeFeedbackCount = int(userData.User.UniqueNegativeFeedbackCount);
			ebayUser.uniquePositiveFeedbackCount = int(userData.User.UniquePositiveFeedbackCount);
			ebayUser.userID = userData.User.UserID;
			ebayUser.userIDChanged = userData.User.UserIDChanged == "true" ? true : false;
			ebayUser.userIDLastChanged = parseDateString(userData.User.UserIDLastChanged);
			for each (var userSubscriptionNode:XML in userData.User.UserSubscription)
				ebayUser.userSubscription.push(userSubscriptionNode.toString());
			ebayUser.vatID = userData.User.VATID;
			ebayUser.vatStatus = userData.user.VATStatus;			

			return ebayUser;
		}  // parseUser


		/**
		 * Creates a VATDetails object.
		 * 
		 * @param requirementsData The XML relevant to the VATDetails object
		 * @return A new VATDetails object
		 */
		internal static function parseVATDetails(detailsData:XMLList):VATDetails
		{
			var vatDetails:VATDetails = new VATDetails();

			vatDetails.businessSeller = detailsData.BusinessSeller == "true" ? true : false;
			vatDetails.restrictedToBusiness = detailsData.RestrictedToBusiness == "true" ? true : false;
			vatDetails.vatPercent = Number(detailsData.VATPercent);

			return vatDetails;
		}  // parseVATDetails


		/**
		 * Creates a VerifiedUserRequirements object.
		 * 
		 * @param requirementsData The XML relevant to the VerifiedUserRequirements object
		 * @return A new VerifiedUserRequirements object
		 */
		internal static function parseVerifiedUserRequirements(requirementsData:XMLList):VerifiedUserRequirements
		{
			var verifiedUserRequirements:VerifiedUserRequirements = new VerifiedUserRequirements();

			verifiedUserRequirements.minimumFeedbackScore = int(requirementsData.MinimumFeedbackScore);
			verifiedUserRequirements.verifiedUser = requirementsData.VerifiedUser == "true" ? true : false;

			return verifiedUserRequirements;
		}  // parseVerifiedUserRequirements


		/**
		 * Creates a WatchList object.
		 * 
		 * @param requirementsData The XML relevant to the WatchList object
		 * @return A new WatchList object
		 */
		internal static function parseWatchList(listData:XMLList):WatchList
		{
			var watchList:WatchList = new WatchList();

			for each (var watchListNode:XML in listData.ItemArray.Item)
				watchList.watchListItem.push(parseWatchListItem(XMLList(watchListNode)));
			watchList.paginationResult = parsePaginationResult(listData.PaginationResult);

			return watchList;
		}  // parseWatchList


		/**
		 * Creates a WatchListItem object.
		 * 
		 * @param requirementsData The XML relevant to the WatchListItem object
		 * @return A new WatchListItem object
		 */
		internal static function parseWatchListItem(itemData:XMLList):WatchListItem
		{
			var watchListItem:WatchListItem = new WatchListItem();

			watchListItem.buyItNowPrice = Number(itemData.BuyItNowPrice);
			watchListItem.eBayNotes = itemData.eBayNotes;
			watchListItem.itemID = itemData.ItemID;
			watchListItem.listingDetails = parseListingDetails(itemData.ListingDetails);
			watchListItem.listingType = itemData.ListingType;
			watchListItem.pictureDetails = parsePictureDetails(itemData.PictureDetails);
			watchListItem.quantityAvailable = int(itemData.QuantityAvailable);
			watchListItem.seller = parseSellerInfo(itemData.Seller);
			watchListItem.sellingStatus = parseSellingStatus(itemData.SellingStatus);
			watchListItem.site = itemData.Site;
			watchListItem.startPrice = Number(itemData.StartPrice);
			watchListItem.timeLeft = itemData.TimeLeft;
			watchListItem.title = itemData.Title;

			return watchListItem;
		}  // parseWatchListItem
	}  // class declaration
}  // package