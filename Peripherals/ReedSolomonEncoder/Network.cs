using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ReedSolomonEncoder
{
    class Network
    {
        private int[] code = new int[15];

        public Network(int[] code, int[] error)
        {
            for (int i = 0; i < this.code.Length; i++)
            {
                this.code[i] = GaluaField.Add(code[i], error[i]);
            }
        }

        public int[] Code
        {
            get { return this.code; }
        }
    }
}
