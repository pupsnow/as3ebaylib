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



package com.adobe.webapis.ebay.codes
{
	/**
	 * Provides constants for the UserStatusCodeType simple type.
	 * 
	 * <p>This class identifies the code types that eBay could use to indicate
	 * the current state or status of an eBay user account.</p>
	 * 
	 * @langversion ActionScript 3.0
	 * @playerversion Flash 9
	 * @tiptext
	 * 
	 * @author Charles Bihis, Adobe Systems Incorporated
	 * 
	 * @see http://developer.ebay.com/DevZone/SOAP/docs/WSDL/xsd/1/simpletype/UserStatusCodeType.htm
	 */
	public final class UserStatus
	{
		public static const UNKNOWN:String = "Unknown";
		public static const SUSPENDED:String = "Suspended";
		public static const CONFIRMED:String = "Confirmed";
		public static const UNCONFIRMED:String = "Unconfirmed";
		public static const GHOST:String = "Ghost";
		public static const IN_MAINTENANCE:String = "InMaintenance";
		public static const DELETED:String = "Deleted";
		public static const CREDIT_CARD_VERIFY:String = "CreditCardVerify";
		public static const ACCOUNT_ON_HOLD:String = "AccountOnHold";
		public static const MERGED:String = "Merged";
		public static const REGISTRATION_CODE_MAIL_OUT:String = "RegistrationCodeMailOut";
		public static const TERM_PENDING:String = "TermPending";
		public static const UNCONFIRMED_HALF_OPT_IN:String = "UnconfirmedHalfOptIn";
		public static const CREDIT_CARD_VERIFY_HALF_OPT_IN:String = "CreditCardVerifyHalfOptIn";
		public static const UNCONFIRMED_PASSPORT:String = "UnconfirmedPassport";
		public static const CREDIT_CARD_VERIFY_PASSPORT:String = "CreditCardVerifyPassport";
		public static const UNCONFIRMED_EXPRESS:String = "UnconfirmedExpress";
		public static const CUSTOM_CODE:String = "CustomCode";
	}  // class declaration
}  // package