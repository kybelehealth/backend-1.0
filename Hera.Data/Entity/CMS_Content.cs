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
    
    public partial class CMS_Content
    {
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2214:DoNotCallOverridableMethodsInConstructors")]
        public CMS_Content()
        {
            this.CMS_Content_Detail = new HashSet<CMS_Content_Detail>();
            this.CMS_Content_Detail_Log = new HashSet<CMS_Content_Detail_Log>();
        }
    
        public int Id { get; set; }
        public string Name { get; set; }
        public int ParentId { get; set; }
        public int OrderNo { get; set; }
        public System.DateTime CreatedAt { get; set; }
        public string Picture { get; set; }
    
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<CMS_Content_Detail> CMS_Content_Detail { get; set; }
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<CMS_Content_Detail_Log> CMS_Content_Detail_Log { get; set; }
    }
}
