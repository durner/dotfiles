from pynvim import Nvim
from deoplete.base.filter import Base
from deoplete.util import truncate_skipping, UserContext, Candidates

class Filter(Base):
    def __init__(self, vim: Nvim) -> None:
        super().__init__(vim)

        self.name = 'converter_truncate_abbr_cpp'

    def filter(self, context: UserContext) -> Candidates:
        max_width = context['max_abbr_width']
        if max_width <= 0:
            return list(context['candidates'])

        footer_width = max_width / 4
        for candidate in context['candidates']:
            can = candidate.get('abbr', candidate['word'])
            if len(can) > max_width:
                can = can.replace("unsigned ", "u ")
            if len(can) > max_width:
                can = can.replace("const ", "c ")
            if len(can) > max_width:
                can = can.replace("long ", "l ")
            if len(can) > max_width:
                candidate['abbr'] = truncate_skipping(
                can, max_width, '...', footer_width)
        return list(context['candidates'])
