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
	import flash.net.URLRequest;
	import flash.net.URLRequestHeader;


	/**
	 * Class that provides authentication and authorization for using
	 * the eBay XML API (version 483).
	 * 
	 * @langversion ActionScript 3.0
	 * @playerversion Flash 9
	 * @tiptext
	 * 
	 * @author Charles Bihis, Adobe Systems Incorporated
	 * 
	 * @see http://developer.ebay.com/
	 * @see http://developer.ebay.com/DevZone/XML/docs/PDF/eBayXMLAPIGuide.pdf
	 */
	public final class AuthAndAuth
	{
		public static var apiDevName:String = "";
		public static var apiAppName:String = "";
		public static var apiCertName:String = "";
		public static var apiAuthToken:String = "";
		public static var endUserIP:String = "";
		public static var isSandbox:Boolean = true;
		
		public static const CONTENT_TYPE:String = "text/xml";
		public static const API_COM_LEVEL:String = "483";
		public static const API_SITEID:String = "0";
		public static const METHOD:String = "POST";
		public static const NAMESPACE:String = "urn:ebay:apis:eBLBaseComponents";
		
		private static var headerDevName:URLRequestHeader = new URLRequestHeader("X-EBAY-API-DEV-NAME", apiDevName);
		private static var headerAppName:URLRequestHeader = new URLRequestHeader("X-EBAY-API-APP-NAME", apiAppName);
		private static var headerCertName:URLRequestHeader =  new URLRequestHeader("X-EBAY-API-CERT-NAME", apiCertName);
		private static var headerContentType:URLRequestHeader = new URLRequestHeader("Content-Type", CONTENT_TYPE);
		private static var headerComLevel:URLRequestHeader = new URLRequestHeader("X-EBAY-API-COMPATIBILITY-LEVEL", API_COM_LEVEL);
		private static var headerSiteID:URLRequestHeader = new URLRequestHeader("X-EBAY-API-SITEID", API_SITEID);


		/**
		 * Write-only property containing developers DevID.
		 */
		public function set apiDevName(apiDevName:String):void
		{
			this.apiDevName = apiDevName;
		}  // apiDevName property
		

		/**
		 * Write-only property containing developers AppID.
		 */
		public function set apiAppName(apiAppName:String):void
		{
			this.apiAppName = apiAppName;
		}  // apiAppName property
		

		/**
		 * Write-only property containing developers CertID.
		 */
		public function set apiCertName(apiCertName:String):void
		{
			this.apiCertName = apiCertName;
		}  // apiCertName property
		

		/**
		 * Write-only property containing developers Authentication Token.
		 */
		public function set apiAuthToken(apiAuthToken:String):void
		{
			this.apiAuthToken = apiAuthToken;
		}  // apiAuthToken property
		
		/**
		 * Write-only property containing developers End-User IP address.
		 * 
		 * <p>Necessary for PlaceOffer API call</p>
		 */		
		public function set endUserIP(endUserIP:String):void
		{
			this.endUserIP = endUserIP;
		}  // endUserIP property
		
		
		/**
		 * Write-only property indicating whether given AuthAndAuth keys are
		 * for the eBay Sandbox or Production servers.
		 */		
		public function set isSandbox(isSandbox:Boolean):void
		{
			this.isSandbox = isSandbox;
		}  // isSandbox property
		
		
		/**
		 * Read-only property for the URLRequest of the API call.
		 */		
		public static function get request():URLRequest
		{
			var request:URLRequest;
			
			if (isSandbox)
			{
				request = new URLRequest("https://api.sandbox.ebay.com/ws/api.dll");
			}  // if statement
			else
			{
				request = new URLRequest("https://api.ebay.com/ws/api.dll");
			}  // else statement

			request.requestHeaders.push(headerDevName);
			request.requestHeaders.push(headerAppName);
			request.requestHeaders.push(headerCertName);
			request.requestHeaders.push(headerContentType);
			request.requestHeaders.push(headerComLevel);
			request.requestHeaders.push(headerSiteID);
			request.method = METHOD;

			return request;
		}  // request property
	}  // class declaration
}  // package