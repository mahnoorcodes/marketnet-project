using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;

namespace MarketNet.L5
{
    public class Dataset
    {
        public object Tables { get; internal set; }

        public static implicit operator Dataset(DataSet v)
        {
            throw new NotImplementedException();
        }
    }
}
