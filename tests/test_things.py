import math

import pytest
from ff.examplelib.things import (
    average,
    fibonacci,
    get_maximum_value,
    get_median,
    get_minimum_value,
    my_add,
    my_div,
    repeat_enthousiastically_several_times,
)
from hypothesis import given
from hypothesis.strategies import floats, integers, lists


def test_version():
    from ff import examplelib

    assert examplelib.__version__ is not None


# an example of a simple unittest.
# the function name must start with ``test``
# see https://docs.pytest.org
def test_my_add_simple():
    assert my_add(2, 3) == 5


# related unittests can be grouped together in a class.
# Such a class must start with ``Test``.
class TestMyDiv:
    def test_simple(self):
        # when comparing floats, be sure to use pytest.approx.
        # this is necessary because of the intricacies of floating-point
        # arithmetic
        assert my_div(1, 8) == pytest.approx(0.125)

    # the parametrize decorator allows us to test multiple cases,
    # without writing many test functions
    @pytest.mark.parametrize(
        ("x", "y", "expect"),
        [(4, 2, 2), (5, 2, 2.5), (1, 3, 0.333_333_333), (5, 5, 1), (0, 3, 0)],
    )
    def test_multiple_cases(self, x, y, expect):
        assert my_div(x, y) == pytest.approx(expect)

    def test_zero_divisor(self):
        # test that the correct exceptions will be raised in certain cases
        with pytest.raises(ValueError, match="divisor cannot be zero"):
            my_div(9, 0)


class TestAverage:
    def test_simple(self):
        assert average([2, 4, 3]) == 3

    # An example of a simple property-based test.
    # In this case, the ``given`` decorator runs the test
    # multiple times with randomly generated lists of numbers.
    # See the ``hypothesis`` library for more info:
    # https://hypothesis.readthedocs.io
    @given(numbers=lists(floats() | integers()))
    def test_fuzzing(self, numbers):
        # Inside the function body of this type of test,
        # we can't check the exact outcome,
        # but we can perform sanity checks on the outputs.
        result = average(numbers)
        assert isinstance(result, float)


class TestFibonacci:
    # example of a test marked as "slow".
    # this test will be skipped unless --runslow is passed at the command line
    # how does it work? see the ``conftest.py`` file
    # and the pytest documentation
    @pytest.mark.slow()
    def test_large(self):
        assert fibonacci(30) > 9

    def test_example(self):
        assert fibonacci(6) == 8

    def test_one_or_smaller(self):
        assert fibonacci(1) == 1
        assert fibonacci(0) == 0


def test_repeat_enthousiastically_several_times():
    assert repeat_enthousiastically_several_times(4) == ("4! 4! 4! 4! 4! 4! 4! 4! 4! 4! 4! 4! ")


# also test when things go wrong
def test_empty_average():
    avg = average([])
    assert avg is math.nan


def test_my_add():
    assert my_add(1, 2) == 3
    assert my_add(-1, 1) == 0
    assert my_add(1.5, 2.5) == 4.0


def test_my_div():
    assert my_div(10, 2) == 5
    assert my_div(5, 2) == 2.5
    with pytest.raises(ValueError):
        my_div(1, 0)


def test_average():
    assert average([1, 2, 3, 4, 5]) == 3
    assert average([1]) == 1
    assert math.isnan(average([]))


def test_fibonacci():
    assert fibonacci(0) == 0
    assert fibonacci(1) == 1
    assert fibonacci(10) == 55


def test_get_maximum_value():
    assert get_maximum_value([1, 2, 3, 4, 5]) == 5
    assert get_maximum_value([-1, -2, -3, -4, -5]) == -1
    with pytest.raises(ValueError):
        get_maximum_value([])


def test_get_minimum_value():
    assert get_minimum_value([1, 2, 3, 4, 5]) == 1
    assert get_minimum_value([-1, -2, -3, -4, -5]) == -5
    with pytest.raises(ValueError):
        get_minimum_value([])


def test_get_median():
    assert get_median([1, 2, 3, 4, 5]) == 3
    assert get_median([1, 2, 3, 4]) == 2.5
    assert get_median([7, 1, 3, 2, 5]) == 3
    with pytest.raises(ValueError):
        get_median([])
