//------------------------------------------------------------------------------
// <auto-generated>
//     This code was generated from a template.
//
//     Manual changes to this file may cause unexpected behavior in your application.
//     Manual changes to this file will be overwritten if the code is regenerated.
// </auto-generated>
//------------------------------------------------------------------------------

namespace Hera.Data.Entity
{
    using System;
    using System.Collections.Generic;
    
    public partial class Notification_Message
    {
        public int Id { get; set; }
        public int NotificationId { get; set; }
        public int LanguageId { get; set; }
        public string Title { get; set; }
        public string Message { get; set; }
    
        public virtual Notification Notification { get; set; }
        public virtual SLanguage SLanguage { get; set; }
    }
}
