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
    
    public partial class Member_Health_Record
    {
        public int Id { get; set; }
        public int MemberId { get; set; }
        public string Name { get; set; }
        public string Photo { get; set; }
        public System.DateTime Date { get; set; }
    
        public virtual Member Member { get; set; }
    }
}
