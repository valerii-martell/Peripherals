using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ReedSolomonEncoder
{
    static class GaluaField
    {
        public const int primitiveElement = 2;

        #region GF(16) Tables

        private static int[,] AddTable = new int[16, 16] {{0,   1,  2,  3,  4,  5,  6,  7,  8,  9, 10, 11, 12, 13, 14, 15},
                                                         {1,   0,  3,  2,  5,  4,  7,  6,  9,  8, 11, 10, 13, 12, 15, 14},
                                                         {2,   3,  0,  1,  6,  7,  4,  5, 10, 11,  8,  9, 14, 15, 12, 13},
                                                         {3,   2,  1,  0,  7,  6,  5,  4, 11, 10,  9,  8, 15, 14, 13, 12},
                                                         {4,   5,  6,  7,  0,  1,  2,  3, 12, 13, 14, 15,  8,  9, 10, 11},
                                                         {5,   4,  7,  6,  1,  0,  3,  2, 13, 12, 15, 14,  9,  8, 11, 10},
                                                         {6,   7,  4,  5,  2,  3,  0,  1, 14, 15, 12, 13, 10, 11, 8,   9},
                                                         {7,   6,  5,  4,  3,  2,  1,  0, 15, 14, 13, 12, 11, 10, 9,   8},
                                                         {8,   9, 10, 11, 12, 13, 14, 15,  0,  1,  2,  3,  4,  5,  6,  7},
                                                         {9,   8, 11, 10, 13, 12, 15, 14,  1,  0,  3,  2,  5,  4,  7,  6},
                                                         {10, 11,  8,  9, 14, 15, 12, 13,  2,  3,  0,  1,  6,  7,  4,  5},
                                                         {11, 10,  9,  8, 15, 14, 13, 12,  3,  2,  1,  0,  7,  6,  5,  4},
                                                         {12, 13, 14, 15,  8,  9, 10, 11,  4,  5,  6,  7,  0,  1,  2,  3},
                                                         {13, 12, 15, 14,  9,  8, 11, 10,  5,  4,  7,  6,  1,  0,  3,  2},
                                                         {14, 15, 12, 13, 10, 11,  8,  9,  6,  7,  4,  5,  2,  3,  0,  1},
                                                         {15, 14, 13, 12, 11, 10,  9,  8,  7,  6,  5,  4,  3,  2,  1,  0}};
        private static int[,] MulTable = new int[16, 16] {{0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
                                                         {0,1,   2,  3,  4,  5,  6,  7,  8,  9,  10, 11, 12, 13, 14, 15},
                                                         {0,2,   4,  6,  8, 10, 12,   14, 3,  1,  7,  5,  11, 9,  15, 13},
                                                         {0,3,   6,  5, 12, 15, 10,   9,  11, 8,  13, 14, 7,  4,  1,  2},
                                                         {0,4,   8, 12,  3,  7, 11,   15, 6,  2,  14, 10, 5,  1,  13, 9},
                                                         {0,5,  10, 15,  7,  2, 13,   8,  14, 11, 4,  1,  9,  12, 3,  6},
                                                         {0,6,  12, 10, 11, 13,  7,   1,  5,  3,  9,  15, 14, 8,  2,  4},
                                                         {0,7,  14,  9, 15,  8,  1,   6,  13, 10, 3,  4,  2,  5,  12, 11},
                                                         {0,8,   3, 11,  6, 14,  5,   13, 12, 4,  15, 7,  10, 2,  9,  1},
                                                         {0,9,   1,  8,  2, 11,  3,   10, 4,  13, 5,  12, 6,  15, 7,  14},
                                                         {0,10,  7, 13, 14,  4,  9,   3,  15, 5,  8,  2,  1,  11, 6,  12},
                                                         {0,11,  5, 14, 10,  1, 15,   4,  7,  12, 2,  9,  13, 6,  8,  3},
                                                         {0,12, 11,  7,  5,  9, 14,   2,  10, 6,  1,  13, 15, 3,  4,  8},
                                                         {0,13,  9,  4,  1, 12,  8,   5,  2,  15, 11, 6,  3,  14, 10, 7},
                                                         {0,14, 15,  1, 13,  3,  2,   12, 9,  7,  6,  8,  4,  10, 11, 5},
                                                         {0,15, 13,  2,  9,  6,  4,   11, 1,  14, 12, 3,  8,  7,  5,  10}};




        private static int[,] PowTable = new int[16, 16] {{0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
                                                         {1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1},
                                                         {1, 2, 4, 8, 3, 6, 12, 11, 5, 10, 7, 14, 15, 13, 9, 1},
                                                         {1, 3, 5, 15, 2, 6, 10, 13, 4, 12, 7, 9, 8, 11, 14, 1},
                                                         {1, 4, 3, 12, 5, 7, 15, 9, 2, 8, 6, 11, 10, 14, 13, 1},
                                                         {1, 5, 2, 10, 4, 7, 8, 14, 3, 15, 6, 13, 12, 9, 11, 1},
                                                         {1, 6, 7, 1, 6, 7, 1, 6, 7, 1, 6, 7, 1, 6, 7, 1},
                                                         {1, 7, 6, 1, 7, 6, 1, 7, 6, 1, 7, 6, 1, 7, 6, 1},
                                                         {1, 8, 12, 10, 15, 1, 8, 12, 10, 15, 1, 8, 12, 10, 15, 1},
                                                         {1, 9, 13, 15, 14, 7, 10, 5, 11, 12, 6, 3, 8, 4, 2, 1},
                                                         {1, 10, 8, 15, 12, 1, 10, 8, 15, 12, 1, 10, 8, 15, 12, 1},
                                                         {1, 11, 9, 12, 13, 6, 15, 3, 14, 8, 7, 4, 10, 2, 5, 1},
                                                         {1, 12, 15, 8, 10, 1, 12, 15, 8, 10, 1, 12, 15, 8, 10, 1},
                                                         {1, 13, 14, 10, 11, 6, 8, 2, 9, 15, 7, 5, 12, 3, 4, 1},
                                                         {1, 14, 11, 8, 9, 7, 12, 4, 13, 10, 6, 2, 15, 5, 3, 1},
                                                         {1, 15, 10, 12, 8, 1, 15, 10, 12, 8, 1, 15, 10, 12, 8, 1}};
        #endregion

        #region GF(16) Operations
        public static int Add(int operand1, int operand2)
        {
            return AddTable[operand1, operand2];
        }

        public static int Add(params int[] operands)
        {
            int sum = 0;
            foreach (int operand in operands)
            {
                sum = Add(sum, operand);
            }
            return sum;
        }

        public static int Sub(int operand1, int operand2)
        {
            int result = operand1 - operand2;
            if (result < 0) result += 15;
            return result;
        }

        public static int Mul(int operand1, int operand2)
        {
            return MulTable[operand1, operand2];
        }

        public static int Pow(int operand, int power)
        {
            int result = 0;

            if (power >= 0)
            {
                result = PowTable[operand, power];
            }
            else
            {
                result = PowTable[operand, 15 + power];
            }
            return result;
        }

        public static void Normalize(int[] polinom)
        {
            for (int i = 1; i < 16; i++)
            {
                if (GaluaField.Mul(polinom[2], i) == 1)
                {
                    polinom[0] = GaluaField.Mul(polinom[0], i);
                    polinom[1] = GaluaField.Mul(polinom[1], i);
                    polinom[2] = GaluaField.Mul(polinom[2], i);
                    break;
                }
            }
        }

        public static int[] IDFT(int[] code)
        {
            int[] result = new int[code.Length];
            for (int i = 0; i < code.Length; i++)
            {
                int C = GaluaField.Pow(GaluaField.primitiveElement, i);

                int[] buffer = new int[code.Length];
                for (int j = 0; j < code.Length; j++)
                {
                    buffer[j] = GaluaField.Mul(code[j], GaluaField.Pow(C, j));
                }
                result[i] = GaluaField.Add(buffer);
            }
            return result;
        }

        public static int[] DFT(int[] code)
        {
            int[] result = new int[code.Length];
            for (int i = 0; i < code.Length; i++)
            {
                int C = GaluaField.Pow(GaluaField.primitiveElement, -1 * i);

                int[] buffer = new int[code.Length];
                for (int j = 0; j < code.Length; j++)
                {
                    buffer[j] = GaluaField.Mul(code[j], GaluaField.Pow(C, j));
                }
                result[i] = GaluaField.Add(buffer);
            }
            return result;
        }

        public static int[] MulVectorMatrix(int[] vector, int[,] matrix)
        {
            int[] result = new int[vector.Length];
            for (int i = 0; i < vector.Length; i++)
            {
                int buf = 0;
                for (int j = 0; j < vector.Length; j++)
                {
                    buf = GaluaField.Add(buf, GaluaField.Mul(vector[j], matrix[j, i]));
                }
                result[i] = buf;
            }
            return result;
        }
        #endregion
    }
}
