package unit.worker;

import com.opencbs.core.accounting.domain.AccountingEntry;
import com.opencbs.core.accounting.dto.MultipleTransactionAmountDto;
import com.opencbs.core.accounting.dto.MultipleTransactionDto;
import com.opencbs.core.accounting.services.AccountService;
import com.opencbs.core.accounting.services.AccountingEntryService;
import com.opencbs.core.officedocuments.services.PrintingFormService;
import com.opencbs.core.workers.AccountingEntryWorker;
import com.opencbs.core.workers.impl.AccountingEntryWorkerImpl;
import fixtues.AccountingEntryFixtures;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;

import java.math.BigDecimal;

import static org.mockito.Mockito.when;

@ExtendWith(MockitoExtension.class)
public class AccountingEntryWorkerTests {

    private AccountingEntryWorker accountingEntryWorker;

    @Mock
    private AccountingEntryService accountingEntryService;

    @Mock
    private AccountService accountService;

    @Mock
    private PrintingFormService printingFormService;

    @BeforeEach
    public void init() {
        accountingEntryWorker = new AccountingEntryWorkerImpl(
                accountingEntryService, accountService, printingFormService
        );
    }
}
