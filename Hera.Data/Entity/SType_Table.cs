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
    
    public partial class SType_Table
    {
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2214:DoNotCallOverridableMethodsInConstructors")]
        public SType_Table()
        {
            this.Translation = new HashSet<Translation>();
        }
    
        public int Id { get; set; }
        public string Name { get; set; }
        public string FQN { get; set; }
        public bool HasTranslation { get; set; }
    
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<Translation> Translation { get; set; }
    }
}
