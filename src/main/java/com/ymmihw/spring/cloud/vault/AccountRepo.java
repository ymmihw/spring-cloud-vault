package com.ymmihw.spring.cloud.vault;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import com.ymmihw.spring.cloud.vault.domain.Account;

@Repository
public interface AccountRepo extends JpaRepository<Account, Long> {

}
