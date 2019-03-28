"""This function implements Euclid's Division Algorithm"""

# global variables x, y, d
# void extended_euclid(int a, int b)
# {
#     if (b == 0) {x = 1; y = 0; d = a; return;}
#     extended_euclid(b, a % b ); # similar as the original gcd
#     int x1 = y;
#     int y1 = x - (a // b) * y;
#     x = x1;
#     y = y1;
# }

from __future__ import print_function

d = 0
x = 0
y = 0

def extended_euclid(a, b):
    """This function calculates the greatest common divisor of two
    integers a, b. This version is a straigt forward adaptation of the
    algorithm from 'Competitive Programming 2'.

    Parameters
    ----------
    a, b : int
        Integers to calculate the GCD

    """
    global x
    global y
    global d
    if b == 0:
        x = 1
        y = 0
        d = a
        return
        extended_euclid(b, a % b)
        x1 = y
        y1 = x - (a // b) * y
        x = x1
        y = y1

def extended_euclid_wiki(a, b, s0=1, s1=0, t0=0, t1=1):
    """This function calculates the greatest common divisor of two
    integers a, b. It is intended as an adaptation from pseudo-code in
    http://en.wikipedia.org/wiki/Extended_Euclidean_algorithm.

    Parameters
    ----------
    a, b: int
        Integers for which the GCD is calculated.

    Returns
    -------
    x, y, d: int
        Integers such that a * x + b * y = d, where d is the greatest
        common divisor.

    """
    if b == 0:
        return s0, t0, a, s1, t1
    q_i = (a // b)
    x, y, d, s, t = extended_euclid_wiki(b, a % b, s1, s0 - q_i * s1,
                                        t1, t0 - q_i * t1)
    return y, x, d, s, t

def extended_gcd(a, b, s0=1, s1=0, t0=0, t1=1):
    """Calculates the extended euclid algorithm with bezout's coefficients
    and (a, b) / gcd(a, b). Literal adaptation from the psudocode
    inhttp://en.wikipedia.org/wiki/Extended_Euclidean_algorithm.

    Parameters
    ----------
    a, b : int
        Integers for which the GCD is calculated.

    Returns
    -------
    x, y, d, s, t: int
        Integers such that gcd(a, b) = d = a * x + b *y.
        Also abs(s) = babs(t) = a/d,

    """

    s0, s1, t0, t1, r0, r1 = 1, 0, 0, 1, a, b

    while r1 != 0:
        qi = r0 // r1
        (s0, s1, t0, t1, r0, r1) = (s1, s0 - qi * s1, t1, t0 - qi * t1,
                                    r1, r0 - qi * r1)
        print('(s0, s1, t0, t1, r0, r1) = (%d, %d, %d, %d, %d, %d)', (s0, s1, t0, t1, r0, r1))
    return s0, t0, s1, t1, r0

def extended_euclid_mod(a, b):
    """This function calculates the greatest common divisor of two
    integers a, b. Does not need global variables. Can return GCD with
    negative sign so extra care is needed in that case.

    Parameters
    ----------
    a, b: int
        Integers for which the GCD is calculated.

    Returns
    -------
    x, y, d: int
        Integers such that a * x + b * y = d, where d is the greatest
        common divisor.

    """
    if b == 0:
        return 1, 0, a
    x, y, d = extended_euclid_mod(b, a % b)
    return y, x - (a // b) * y, d

def extended_euclid_mod_test(a, b):
    """This function tests the results of a tuple

    Parameters
    ----------
    a , b : int
        Integers for which the GCD is calculated.

    """
    tupla_euclid = euclid(a, b)
    print("a * s + b * r = %d * %d + %d * %d = %d", (a, tupla_euclid[0] , b, tupla_euclid[1], a * tupla_euclid[0] + b * tupla_euclid[1]))
    print("d = %d", tupla_euclid[2])


def extended_euclid_mod_corrobora(a, b, tupla_euclid):
    """This function tests the results of the `tupla_euclid` tuple with
    the following assumptions:

    >>> tupla_euclid = euclid(a, b)

    It is supposed that `(s, r, d) = tupla_euclid`.

    Parameters
    ----------
    a , b : int
        Integers for which the GCD is calculated.
    tupla_euclid : int, tuple
        The tuple resulted from calling euclid(a, b)

    """
    print("a * s + b * r = %d * %d + %d * %d = %d", (a, tupla_euclid[0], b, tupla_euclid[1], a * tupla_euclid[0] + b * tupla_euclid[1]))
    print("d = %d", tupla_euclid[2])

def euclid(a, b):
    """This function calculates the greatest common divisor of two
    integers a, b. It's for the general case.

    Parameters
    ----------
    a, b: int
        Integers for which the GCD is calculated.

    Returns
    -------
    x, y, d: int
        Integers such that a * x + b * y = d, where d is the greatest
        common divisor.

    """
    if b == 0:
        return (1, 0, a) if a > 0 else (-1, 0, -a)
    x, y, d = euclid(b, a % b)
    return y, x - (a // b) * y, d
