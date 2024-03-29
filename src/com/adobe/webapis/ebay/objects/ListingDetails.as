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
	 * Various details about a listing, some of which are calculated or
	 * derived after the item is listed.
	 * 
	 * <p>Contains the following additional objects:
	 * 	<ul>
	 *		<li><code>ExpressItemRequirements</code></li>
	 * 	</ul>
	 * </p>
	 * 
	 * @langversion ActionScript 3.0
	 * @playerversion Flash 9
	 * @tiptext
	 * 
	 * @author Charles Bihis, Adobe Systems Incorporated
	 * 
	 * @see com.adobe.webapis.ebay.objects.ExpressItemRequirements
	 */
	public class ListingDetails
	{
		public var adult:Boolean;
		public var bindingAuction:Boolean;
		public var buyItNowAvailable:Boolean;
		public var checkoutEnabled:Boolean;
		public var convertedBuyItNowPrice:Number;
		public var convertedReservePrice:Number;		
		public var convertedStartPrice:Number;
		public var endTime:Date;
		public var expressItemRequirements:ExpressItemRequirements;
		public var expressListing:Boolean;
		public var hasPublicMessages:Boolean;
		public var hasReservePrice:Boolean;
		public var hasUnansweredQuestions:Boolean;
		public var minimumBestOfferMessage:String;
		public var minimumBestOfferPrice:Number;
		public var relistedItemID:String;
		public var secondChanceOriginalItemID:String;
		public var sellerBusinessType:String;
		public var startTime:Date;
		public var tcrOriginalItemID:String;
		public var viewItemURL:String;


		/**
		 * Constructor for the ListingDetails class.
		 * 
		 * <p>Creates a new ListingDetails object.</p>
		 */
		public function ListingDetails()
		{
		}  // ListingDetails
	}  // class declaration
}  // package