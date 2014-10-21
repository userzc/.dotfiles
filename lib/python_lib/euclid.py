"""This function implements Euclid's Division Algorithm"""

# global variables x, y, d
# void extendedEuclid(int a, int b)
# {
#     if (b == 0) {x = 1; y = 0; d = a; return;}
#     extendedEuclid(b, a % b ); # similar as the original gcd
#     int x1 = y;
#     int y1 = x - (a / b) * y;
#     x = x1;
#     y = y1;
# }

d = 0
x = 0
y = 0

def extendedEuclid(a, b):
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
    extendedEuclid(b, a % b)
    x1 = y
    y1 = x - ( a / b ) * y
    x = x1
    y = y1

def extendedEuclid_mod(a, b):
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
    x, y, d = extendedEuclid_mod(b, a % b)
    return y, x - (a / b) * y, d

def extendedEuclid_mod_test(a, b):
    """This function tests the results of a tuple

    Parameters
    ----------
    a , b : int
        Integers for which the GCD is calculated.

    """
    tupla_euclid = euclid(a, b)
    print "a * s + b * r =", a * tupla_euclid[0] + b * tupla_euclid[1]
    print "d =", tupla_euclid[2]

def extendedEuclid_mod_corrobora(a, b, tupla_euclid):
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
    print "a * s + b * r =", a * tupla_euclid[0] + b * tupla_euclid[1]
    print "d =", tupla_euclid[2]

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
    return y, x - (a / b) * y, d
